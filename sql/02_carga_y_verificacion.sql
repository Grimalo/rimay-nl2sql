-- =====================================================================
-- 02_carga_y_verificacion.sql
-- Paso previo: importar consolidado_2019-2022_HH_original.csv en
-- public.otm_staging (Table Editor → Insert → Import data from CSV).
-- Este script normaliza el staging hacia las tablas definitivas.
-- =====================================================================

-- (0) Tabla de staging: se crea ANTES de importar el CSV; todo como texto
--     para no perder los ceros a la izquierda del código patrimonial.
create table if not exists public.otm_staging (
  anio text, servicio_asistencial text, cobertura text, ejecutor text,
  codigo_patrimonial text, denominacion_equipo text, num_otm text,
  descripcion_actividades text, tipo_mantenimiento text,
  horas_hombre_programadas text, horas_hombre_ejecutadas text,
  fecha_inicio text, fecha_termino text,
  costo_repuesto text, costo_mano_obra text, costo_total text
);
alter table public.otm_staging enable row level security;
-- >>> importar aquí el CSV y luego ejecutar lo que sigue <<<

insert into public.tipos_equipo (denominacion)
  select distinct denominacion_equipo from public.otm_staging order by 1;

insert into public.servicios (nombre)
  select distinct servicio_asistencial from public.otm_staging order by 1;

insert into public.ejecutores (razon_social)
  select distinct ejecutor from public.otm_staging order by 1;

insert into public.equipos (codigo_patrimonial, id_tipo_equipo, cobertura)
  select distinct s.codigo_patrimonial, t.id_tipo_equipo, s.cobertura
  from public.otm_staging s
  join public.tipos_equipo t on t.denominacion = s.denominacion_equipo
  order by 1;

insert into public.ordenes_mantenimiento
  (num_otm, anio, codigo_patrimonial, id_servicio, id_ejecutor, tipo_mantenimiento,
   descripcion_actividades, horas_hombre_programadas, horas_hombre_ejecutadas,
   fecha_inicio, fecha_termino, costo_repuesto, costo_mano_obra, costo_total)
  select s.num_otm, s.anio::smallint, s.codigo_patrimonial, sv.id_servicio, ej.id_ejecutor,
         s.tipo_mantenimiento, s.descripcion_actividades,
         nullif(s.horas_hombre_programadas,'')::numeric, s.horas_hombre_ejecutadas::numeric,
         s.fecha_inicio::date, s.fecha_termino::date,
         s.costo_repuesto::numeric, s.costo_mano_obra::numeric, s.costo_total::numeric
  from public.otm_staging s
  join public.servicios  sv on sv.nombre       = s.servicio_asistencial
  join public.ejecutores ej on ej.razon_social = s.ejecutor
  order by s.fecha_inicio, s.num_otm;

-- ---------- Verificación contra el CSV (valores esperados calculados con pandas)
-- ordenes 7872 · equipos 1412 · tipos 83 · servicios 104 · ejecutores 29
-- costo_total 7587149.93 · repuesto 4696867.92 · mano de obra 2890282.01
-- HH ejecutadas 50101.57 · HH programadas 29429.96 · HH prog. nulas 3505
-- por año: 1056 / 1903 / 2352 / 2561 · por tipo: CI 3505 · CP 113 · PP 4254
select
  (select count(*) from ordenes_mantenimiento)                         as ordenes,
  (select count(*) from equipos)                                       as equipos,
  (select count(*) from tipos_equipo)                                  as tipos_equipo,
  (select count(*) from servicios)                                     as servicios,
  (select count(*) from ejecutores)                                    as ejecutores,
  (select sum(costo_total) from ordenes_mantenimiento)                 as costo_total,
  (select sum(costo_repuesto) from ordenes_mantenimiento)              as costo_repuesto,
  (select sum(costo_mano_obra) from ordenes_mantenimiento)             as costo_mano_obra,
  (select sum(horas_hombre_ejecutadas) from ordenes_mantenimiento)     as hh_ejecutadas,
  (select sum(horas_hombre_programadas) from ordenes_mantenimiento)    as hh_programadas,
  (select count(*) from ordenes_mantenimiento where horas_hombre_programadas is null) as hh_prog_nulas,
  (select count(*) from ordenes_mantenimiento where horas_hombre_programadas is null and tipo_mantenimiento <> 'CI') as nulas_fuera_de_ci,
  (select sum(length(descripcion_actividades)) from ordenes_mantenimiento) as chars_descripcion,
  (select string_agg(anio||':'||n, ' ' order by anio) from (select anio, count(*) n from ordenes_mantenimiento group by 1) a) as por_anio,
  (select string_agg(tipo_mantenimiento||':'||n, ' ' order by tipo_mantenimiento) from (select tipo_mantenimiento, count(*) n from ordenes_mantenimiento group by 1) a) as por_tipo;

-- Una vez verificado:  drop table public.otm_staging;
