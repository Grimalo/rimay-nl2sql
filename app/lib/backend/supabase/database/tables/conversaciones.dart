import '../database.dart';

class ConversacionesTable extends SupabaseTable<ConversacionesRow> {
  @override
  String get tableName => 'conversaciones';

  @override
  ConversacionesRow createRow(Map<String, dynamic> data) =>
      ConversacionesRow(data);
}

class ConversacionesRow extends SupabaseDataRow {
  ConversacionesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConversacionesTable();

  String? get idConversacion => getField<String>('id_conversacion');
  set idConversacion(String? value) =>
      setField<String>('id_conversacion', value);

  String get idDispositivo => getField<String>('id_dispositivo')!;
  set idDispositivo(String value) => setField<String>('id_dispositivo', value);

  String? get titulo => getField<String>('titulo');
  set titulo(String? value) => setField<String>('titulo', value);

  DateTime? get creadoEn => getField<DateTime>('creado_en');
  set creadoEn(DateTime? value) => setField<DateTime>('creado_en', value);

  DateTime? get actualizadoEn => getField<DateTime>('actualizado_en');
  set actualizadoEn(DateTime? value) =>
      setField<DateTime>('actualizado_en', value);

  int? get nMensajes => getField<int>('n_mensajes');
  set nMensajes(int? value) => setField<int>('n_mensajes', value);
}
