import '../database.dart';

class OrdenesMantenimientoTable extends SupabaseTable<OrdenesMantenimientoRow> {
  @override
  String get tableName => 'ordenes_mantenimiento';

  @override
  OrdenesMantenimientoRow createRow(Map<String, dynamic> data) =>
      OrdenesMantenimientoRow(data);
}

class OrdenesMantenimientoRow extends SupabaseDataRow {
  OrdenesMantenimientoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrdenesMantenimientoTable();

  int get idOrden => getField<int>('id_orden')!;
  set idOrden(int value) => setField<int>('id_orden', value);

  String get numOtm => getField<String>('num_otm')!;
  set numOtm(String value) => setField<String>('num_otm', value);

  int get anio => getField<int>('anio')!;
  set anio(int value) => setField<int>('anio', value);

  String get codigoPatrimonial => getField<String>('codigo_patrimonial')!;
  set codigoPatrimonial(String value) =>
      setField<String>('codigo_patrimonial', value);

  int get idServicio => getField<int>('id_servicio')!;
  set idServicio(int value) => setField<int>('id_servicio', value);

  int get idEjecutor => getField<int>('id_ejecutor')!;
  set idEjecutor(int value) => setField<int>('id_ejecutor', value);

  String get tipoMantenimiento => getField<String>('tipo_mantenimiento')!;
  set tipoMantenimiento(String value) =>
      setField<String>('tipo_mantenimiento', value);

  String get descripcionActividades =>
      getField<String>('descripcion_actividades')!;
  set descripcionActividades(String value) =>
      setField<String>('descripcion_actividades', value);

  double? get horasHombreProgramadas =>
      getField<double>('horas_hombre_programadas');
  set horasHombreProgramadas(double? value) =>
      setField<double>('horas_hombre_programadas', value);

  double get horasHombreEjecutadas =>
      getField<double>('horas_hombre_ejecutadas')!;
  set horasHombreEjecutadas(double value) =>
      setField<double>('horas_hombre_ejecutadas', value);

  DateTime get fechaInicio => getField<DateTime>('fecha_inicio')!;
  set fechaInicio(DateTime value) => setField<DateTime>('fecha_inicio', value);

  DateTime get fechaTermino => getField<DateTime>('fecha_termino')!;
  set fechaTermino(DateTime value) =>
      setField<DateTime>('fecha_termino', value);

  double get costoRepuesto => getField<double>('costo_repuesto')!;
  set costoRepuesto(double value) => setField<double>('costo_repuesto', value);

  double get costoManoObra => getField<double>('costo_mano_obra')!;
  set costoManoObra(double value) => setField<double>('costo_mano_obra', value);

  double get costoTotal => getField<double>('costo_total')!;
  set costoTotal(double value) => setField<double>('costo_total', value);
}
