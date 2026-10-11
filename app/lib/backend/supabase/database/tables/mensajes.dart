import '../database.dart';

class MensajesTable extends SupabaseTable<MensajesRow> {
  @override
  String get tableName => 'mensajes';

  @override
  MensajesRow createRow(Map<String, dynamic> data) => MensajesRow(data);
}

class MensajesRow extends SupabaseDataRow {
  MensajesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MensajesTable();

  int get idMensaje => getField<int>('id_mensaje')!;
  set idMensaje(int value) => setField<int>('id_mensaje', value);

  String get idConversacion => getField<String>('id_conversacion')!;
  set idConversacion(String value) =>
      setField<String>('id_conversacion', value);

  String get rol => getField<String>('rol')!;
  set rol(String value) => setField<String>('rol', value);

  String get contenido => getField<String>('contenido')!;
  set contenido(String value) => setField<String>('contenido', value);

  String? get estado => getField<String>('estado');
  set estado(String? value) => setField<String>('estado', value);

  String? get sqlGenerado => getField<String>('sql_generado');
  set sqlGenerado(String? value) => setField<String>('sql_generado', value);

  int? get nFilas => getField<int>('n_filas');
  set nFilas(int? value) => setField<int>('n_filas', value);

  int? get idConsulta => getField<int>('id_consulta');
  set idConsulta(int? value) => setField<int>('id_consulta', value);

  DateTime? get creadoEn => getField<DateTime>('creado_en');
  set creadoEn(DateTime? value) => setField<DateTime>('creado_en', value);
}
