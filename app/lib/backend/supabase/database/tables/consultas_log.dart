import '../database.dart';

class ConsultasLogTable extends SupabaseTable<ConsultasLogRow> {
  @override
  String get tableName => 'consultas_log';

  @override
  ConsultasLogRow createRow(Map<String, dynamic> data) => ConsultasLogRow(data);
}

class ConsultasLogRow extends SupabaseDataRow {
  ConsultasLogRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConsultasLogTable();

  int get idConsulta => getField<int>('id_consulta')!;
  set idConsulta(int value) => setField<int>('id_consulta', value);

  DateTime? get creadoEn => getField<DateTime>('creado_en');
  set creadoEn(DateTime? value) => setField<DateTime>('creado_en', value);

  String get pregunta => getField<String>('pregunta')!;
  set pregunta(String value) => setField<String>('pregunta', value);

  String? get sqlGenerado => getField<String>('sql_generado');
  set sqlGenerado(String? value) => setField<String>('sql_generado', value);

  String get estado => getField<String>('estado')!;
  set estado(String value) => setField<String>('estado', value);

  String? get detalleError => getField<String>('detalle_error');
  set detalleError(String? value) => setField<String>('detalle_error', value);

  int? get nFilas => getField<int>('n_filas');
  set nFilas(int? value) => setField<int>('n_filas', value);

  String? get respuesta => getField<String>('respuesta');
  set respuesta(String? value) => setField<String>('respuesta', value);

  String? get modeloLlm1 => getField<String>('modelo_llm1');
  set modeloLlm1(String? value) => setField<String>('modelo_llm1', value);

  String? get modeloLlm2 => getField<String>('modelo_llm2');
  set modeloLlm2(String? value) => setField<String>('modelo_llm2', value);

  int? get msLlm1 => getField<int>('ms_llm1');
  set msLlm1(int? value) => setField<int>('ms_llm1', value);

  int? get msSql => getField<int>('ms_sql');
  set msSql(int? value) => setField<int>('ms_sql', value);

  int? get msLlm2 => getField<int>('ms_llm2');
  set msLlm2(int? value) => setField<int>('ms_llm2', value);

  int? get msTotal => getField<int>('ms_total');
  set msTotal(int? value) => setField<int>('ms_total', value);

  int? get tokensEntrada => getField<int>('tokens_entrada');
  set tokensEntrada(int? value) => setField<int>('tokens_entrada', value);

  int? get tokensSalida => getField<int>('tokens_salida');
  set tokensSalida(int? value) => setField<int>('tokens_salida', value);

  int? get intentos => getField<int>('intentos');
  set intentos(int? value) => setField<int>('intentos', value);
}
