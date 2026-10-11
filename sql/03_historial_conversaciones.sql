-- =====================================================================
-- 03_historial_conversaciones.sql
-- Historial de conversaciones del chatbot: cada conversación agrupa los
-- mensajes de una sesión de consulta y recibe un título automático
-- generado por el LLM-1 en la misma llamada que produce el SQL
-- (no añade llamadas ni costo adicional al modelo).
--
-- El aplicativo no tiene autenticación de usuarios, de modo que las
-- conversaciones se asocian a un identificador de dispositivo generado
-- por la aplicación y almacenado localmente. Cuando se incorpore
-- autenticación, id_dispositivo se sustituye por el identificador de
-- usuario sin alterar el resto del diseño.
-- =====================================================================

create table public.conversaciones (
  id_conversacion uuid primary key default gen_random_uuid(),
  id_dispositivo  text not null,
  titulo          text,                       -- NULL hasta el primer intercambio
  creado_en       timestamptz not null default now(),
  actualizado_en  timestamptz not null default now(),
  n_mensajes      integer not null default 0
);
create index on public.conversaciones (id_dispositivo, actualizado_en desc);

create table public.mensajes (
  id_mensaje      bigint generated always as identity primary key,
  id_conversacion uuid not null references public.conversaciones on delete cascade,
  rol             text not null check (rol in ('usuario','asistente')),
  contenido       text not null,
  estado          text,                       -- solo en los mensajes del asistente
  sql_generado    text,                       -- evidencia auditable (EX del Cap. 4)
  n_filas         integer,
  id_consulta     bigint references public.consultas_log,
  creado_en       timestamptz not null default now()
);
create index on public.mensajes (id_conversacion, id_mensaje);

alter table public.conversaciones enable row level security;
alter table public.mensajes       enable row level security;
-- Sin políticas: ni anon ni authenticated acceden. El historial se lee y
-- escribe únicamente desde la Edge Function, que filtra por id_dispositivo.
-- El rol chatbot_lectura tampoco las alcanza: el SQL que genera el LLM no
-- puede leer el historial de nadie.

-- Verificación
select
  (select count(*) from public.conversaciones) as conversaciones,
  (select count(*) from public.mensajes)       as mensajes;
