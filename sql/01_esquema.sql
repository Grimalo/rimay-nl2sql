-- =====================================================================
-- 01_esquema.sql · Aplicativo de tesis (Supabase / PostgreSQL)
-- Esquema relacional del consolidado de OTM 2019-2022 del HNERM.
-- Fuente: consolidado_2019-2022_HH_original.csv (7 872 filas, 16 columnas)
-- =====================================================================

create extension if not exists unaccent with schema extensions;

-- ---------- Catálogos ------------------------------------------------
create table public.tipos_mantenimiento (
  codigo     text primary key check (codigo in ('PP','CI','CP')),
  nombre     text not null,
  categoria  text not null check (categoria in ('PREVENTIVO','CORRECTIVO'))
);
insert into public.tipos_mantenimiento values
  ('PP','PREVENTIVO PROGRAMADO','PREVENTIVO'),
  ('CI','CORRECTIVO IMPREVISTO','CORRECTIVO'),
  ('CP','CORRECTIVO PROGRAMADO','CORRECTIVO');

create table public.tipos_equipo (
  id_tipo_equipo smallint generated always as identity primary key,
  denominacion   text not null unique
);

create table public.servicios (
  id_servicio smallint generated always as identity primary key,
  nombre      text not null unique
);

create table public.ejecutores (
  id_ejecutor  smallint generated always as identity primary key,
  razon_social text not null unique          -- solo empresas; no hay personas naturales
);

-- ---------- Equipos (unidad física = código patrimonial) --------------
create table public.equipos (
  codigo_patrimonial text primary key check (codigo_patrimonial ~ '^[0-9]{8}$'),
  id_tipo_equipo     smallint not null references public.tipos_equipo,
  cobertura          text not null
);
create index on public.equipos (id_tipo_equipo);

-- ---------- Órdenes de trabajo de mantenimiento -----------------------
-- num_otm NO es único en la fuente (050988-2020 aparece en dos equipos),
-- por eso la clave primaria es sustituta.
-- El servicio va en la orden y no en el equipo: 30 equipos registran OTM
-- en más de un servicio (fueron reubicados).
create table public.ordenes_mantenimiento (
  id_orden                 integer generated always as identity primary key,
  num_otm                  text not null,
  anio                     smallint not null check (anio between 2019 and 2022),
  codigo_patrimonial       text not null references public.equipos,
  id_servicio              smallint not null references public.servicios,
  id_ejecutor              smallint not null references public.ejecutores,
  tipo_mantenimiento       text not null references public.tipos_mantenimiento,
  descripcion_actividades  text not null,
  horas_hombre_programadas numeric(7,2),          -- NULL estructural en CI (lo imprevisto no se programa)
  horas_hombre_ejecutadas  numeric(7,2) not null,
  fecha_inicio             date not null,
  fecha_termino            date not null,
  costo_repuesto           numeric(12,2) not null,
  costo_mano_obra          numeric(12,2) not null,
  costo_total              numeric(12,2) not null,
  check (fecha_termino >= fecha_inicio)
);
create index on public.ordenes_mantenimiento (codigo_patrimonial, fecha_inicio);
create index on public.ordenes_mantenimiento (id_servicio);
create index on public.ordenes_mantenimiento (id_ejecutor);
create index on public.ordenes_mantenimiento (tipo_mantenimiento);
create index on public.ordenes_mantenimiento (fecha_inicio);
create index on public.ordenes_mantenimiento (num_otm);

-- ---------- Bitácora de consultas (trazabilidad y métricas del Cap. 4) -
create table public.consultas_log (
  id_consulta   bigint generated always as identity primary key,
  creado_en     timestamptz not null default now(),
  pregunta      text not null,
  sql_generado  text,
  estado        text not null,      -- OK | RECHAZADA | ERROR_SQL | ERROR_LLM | FUERA_DE_DOMINIO
  detalle_error text,
  n_filas       integer,
  respuesta     text,
  modelo_llm1   text,
  modelo_llm2   text,
  ms_llm1       integer,
  ms_sql        integer,
  ms_llm2       integer,
  ms_total      integer,
  tokens_entrada integer,
  tokens_salida  integer,
  intentos       smallint     -- llamadas al LLM-1 (1 = sin autocorrección)
);

-- ---------- Seguridad --------------------------------------------------
-- RLS activo en todo. Sin políticas para anon/authenticated: la Data API
-- no expone nada. El chatbot lee mediante un rol propio, sin login,
-- que solo tiene SELECT sobre las cinco tablas del dominio.
alter table public.tipos_mantenimiento   enable row level security;
alter table public.tipos_equipo          enable row level security;
alter table public.servicios             enable row level security;
alter table public.ejecutores            enable row level security;
alter table public.equipos               enable row level security;
alter table public.ordenes_mantenimiento enable row level security;
alter table public.consultas_log         enable row level security;

do $$ begin
  if not exists (select 1 from pg_roles where rolname = 'chatbot_lectura') then
    create role chatbot_lectura nologin;
  end if;
end $$;
grant chatbot_lectura to postgres;           -- permite SET LOCAL ROLE desde la Edge Function
grant usage on schema public, extensions to chatbot_lectura;
grant select on public.tipos_mantenimiento, public.tipos_equipo, public.servicios,
                public.ejecutores, public.equipos, public.ordenes_mantenimiento
      to chatbot_lectura;

create policy lectura_chatbot on public.tipos_mantenimiento   for select to chatbot_lectura using (true);
create policy lectura_chatbot on public.tipos_equipo          for select to chatbot_lectura using (true);
create policy lectura_chatbot on public.servicios             for select to chatbot_lectura using (true);
create policy lectura_chatbot on public.ejecutores            for select to chatbot_lectura using (true);
create policy lectura_chatbot on public.equipos               for select to chatbot_lectura using (true);
create policy lectura_chatbot on public.ordenes_mantenimiento for select to chatbot_lectura using (true);
