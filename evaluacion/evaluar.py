# -*- coding: utf-8 -*-
"""Mide la exactitud de ejecución (EX) de la Edge Function "consulta".

Para cada pregunta del set llama a la función, toma las filas que devolvió el SQL
generado y las compara con el resultado del SQL de referencia. No compara cadenas
de SQL: dos sentencias distintas pueden ser igualmente correctas.

  EX estricta : mismo multiconjunto de filas, sin importar nombres ni orden de columnas.
  EX relajada : las columnas de la referencia están contenidas en las devueltas
                (el modelo agregó columnas de contexto, pero los valores pedidos coinciden).
  Casos sin SQL (no calculable / fuera de dominio / seguridad): acierta si el estado
  devuelto es uno de los esperados.

Uso (solo biblioteca estándar):
  set SUPABASE_URL=https://<ref>.supabase.co
  set SUPABASE_KEY=<clave publicable sb_publishable_...>
  python evaluar.py [--con-respuesta] [--solo A01,B02] [--repeticiones 1]
Salidas: resultados_evaluacion.csv, resultados_evaluacion.json y resumen en pantalla.
"""
import os, sys, json, csv, time, itertools, urllib.request, urllib.error, argparse, datetime

TOL = 0.011  # tolerancia numérica (redondeo a 2 decimales)

# Equivalencias de etiqueta declaradas: designan el mismo valor del catálogo y
# no constituyen una respuesta distinta. El prompt pide devolver columnas
# legibles, de modo que el modelo puede responder "CORRECTIVO IMPREVISTO"
# donde la referencia escribió "CI". Se normalizan ambas al código.
EQUIVALENCIAS = {
    "PREVENTIVO PROGRAMADO": "PP", "CORRECTIVO IMPREVISTO": "CI", "CORRECTIVO PROGRAMADO": "CP",
}
MESES = {"ENERO": 1, "FEBRERO": 2, "MARZO": 3, "ABRIL": 4, "MAYO": 5, "JUNIO": 6,
         "JULIO": 7, "AGOSTO": 8, "SETIEMBRE": 9, "SEPTIEMBRE": 9, "OCTUBRE": 10,
         "NOVIEMBRE": 11, "DICIEMBRE": 12}

def norm(v):
    if v is None: return None
    if isinstance(v, bool): return v
    if isinstance(v, (int, float)): return round(float(v), 6)
    s = str(v).strip()
    try: return round(float(s), 6)
    except ValueError: pass
    if len(s) >= 10 and s[4] == "-" and s[7] == "-": return s[:10]      # fechas
    s = " ".join(s.upper().split())
    if s in EQUIVALENCIAS: return EQUIVALENCIAS[s]
    if s in MESES: return float(MESES[s])                                # "AGOSTO" == 8
    if len(s) == 7 and s[4] == "-" and s[:4].isdigit() and s[5:].isdigit():
        return float(int(s[5:]))                                         # "2021-08" == 8
    return s

def iguales(a, b):
    if isinstance(a, float) and isinstance(b, float): return abs(a - b) <= TOL
    return a == b

def fila_igual(f, g): return len(f) == len(g) and all(iguales(x, y) for x, y in zip(f, g))

def multiconjunto_igual(A, B):
    if len(A) != len(B): return False
    pendientes = list(B)
    for f in A:
        for i, g in enumerate(pendientes):
            if fila_igual(f, g): pendientes.pop(i); break
        else: return False
    return True

def comparar(ref, filas):
    """ref: lista de listas; filas: lista de dicts devueltos por la función."""
    R = [[norm(v) for v in f] for f in ref]
    if not filas: return False, False
    cols = list(filas[0].keys())
    P = [[norm(f.get(c)) for c in cols] for f in filas]
    k, n = len(R[0]), len(cols)
    if n < k or len(P) != len(R): return False, False
    if n > 8: return False, False
    for perm in itertools.permutations(range(n), k):
        if multiconjunto_igual(R, [[f[i] for i in perm] for f in P]):
            return (n == k), True
    return False, False

def llamar(url, clave, pregunta, con_respuesta):
    cuerpo = json.dumps({"pregunta": pregunta, "omitir_respuesta": not con_respuesta}).encode("utf-8")
    req = urllib.request.Request(url, data=cuerpo, method="POST", headers={
        "Content-Type": "application/json", "apikey": clave, "Authorization": f"Bearer {clave}"})
    t = time.time()
    try:
        with urllib.request.urlopen(req, timeout=120) as r: d = json.loads(r.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        d = {"estado": f"HTTP_{e.code}", "detalle": e.read().decode("utf-8", "ignore")[:300]}
    except Exception as e:
        d = {"estado": "ERROR_RED", "detalle": str(e)[:300]}
    d["_ms_cliente"] = int((time.time() - t) * 1000)
    return d

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--con-respuesta", action="store_true", help="también ejecuta el LLM-2 (mide latencia y costo completos)")
    ap.add_argument("--solo", default="")
    ap.add_argument("--repeticiones", type=int, default=1)
    ap.add_argument("--set", default="set_evaluacion.json")
    a = ap.parse_args()
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/functions/v1/consulta"
    clave = os.environ["SUPABASE_KEY"]
    casos = json.load(open(a.set, encoding="utf-8"))
    if a.solo: casos = [c for c in casos if c["id"] in a.solo.split(",")]

    reg = []
    for rep in range(1, a.repeticiones + 1):
        for c in casos:
            d = llamar(url, clave, c["pregunta"], a.con_respuesta)
            estado = d.get("estado", "?")
            if c["sql_referencia"]:
                estricta, relajada = comparar(c["resultado_referencia"], d.get("filas") or []) if estado == "OK" else (False, False)
                acierto = relajada
            else:
                esperados = c["estado_esperado"].split("|")
                estricta = relajada = acierto = (estado in esperados) or ("OK_SIN_EFECTO" in esperados and estado == "OK")
            m = d.get("metricas") or {}
            reg.append({"rep": rep, "id": c["id"], "categoria": c["categoria"], "dificultad": c["dificultad"],
                        "pregunta": c["pregunta"], "estado": estado, "estado_esperado": c["estado_esperado"],
                        "ex_estricta": int(estricta), "ex_relajada": int(relajada), "acierto": int(acierto),
                        "sql_generado": d.get("sql"), "sql_referencia": c["sql_referencia"], "n_filas": d.get("n_filas"),
                        "intentos": m.get("intentos"), "ms_llm1": m.get("ms_llm1"), "ms_sql": m.get("ms_sql"),
                        "ms_llm2": m.get("ms_llm2"), "ms_total": m.get("ms_total"), "ms_cliente": d["_ms_cliente"],
                        "tokens_entrada": m.get("tokens_entrada"), "tokens_salida": m.get("tokens_salida"),
                        "detalle": d.get("detalle"), "respuesta": d.get("respuesta"),
                        "filas_devueltas": json.dumps((d.get("filas") or [])[:12], ensure_ascii=False)})
            print(f'{c["id"]} {"OK " if acierto else "MAL"} estado={estado} ms={m.get("ms_total")}', flush=True)

    sello = datetime.datetime.now().strftime("%Y%m%d_%H%M")
    with open(f"resultados_evaluacion_{sello}.csv", "w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=list(reg[0].keys())); w.writeheader(); w.writerows(reg)
    json.dump(reg, open(f"resultados_evaluacion_{sello}.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

    con_sql = [r for r in reg if r["sql_referencia"]]; sin_sql = [r for r in reg if not r["sql_referencia"]]
    pct = lambda xs, k: f'{100*sum(x[k] for x in xs)/len(xs):.1f} % ({sum(x[k] for x in xs)}/{len(xs)})' if xs else "—"
    print("\n=== RESUMEN ===")
    print("EX estricta :", pct(con_sql, "ex_estricta")); print("EX relajada :", pct(con_sql, "ex_relajada"))
    print("Casos sin SQL (rechazo correcto):", pct(sin_sql, "acierto"))
    for cat in sorted({r["categoria"] for r in reg}): print(f"  {cat:14s}", pct([r for r in reg if r["categoria"] == cat], "acierto"))
    ms = sorted(r["ms_total"] for r in reg if r["ms_total"])
    if ms: print(f"Latencia total (servidor): mediana {ms[len(ms)//2]} ms · máx {ms[-1]} ms")
    te = sum(r["tokens_entrada"] or 0 for r in reg); ts = sum(r["tokens_salida"] or 0 for r in reg)
    print(f"Tokens: entrada {te} · salida {ts} · promedio por consulta {round((te+ts)/len(reg))}")

if __name__ == "__main__":
    main()
