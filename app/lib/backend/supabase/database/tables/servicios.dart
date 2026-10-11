import '../database.dart';

class ServiciosTable extends SupabaseTable<ServiciosRow> {
  @override
  String get tableName => 'servicios';

  @override
  ServiciosRow createRow(Map<String, dynamic> data) => ServiciosRow(data);
}

class ServiciosRow extends SupabaseDataRow {
  ServiciosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ServiciosTable();

  int get idServicio => getField<int>('id_servicio')!;
  set idServicio(int value) => setField<int>('id_servicio', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);
}
