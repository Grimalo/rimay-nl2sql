import '../database.dart';

class TiposMantenimientoTable extends SupabaseTable<TiposMantenimientoRow> {
  @override
  String get tableName => 'tipos_mantenimiento';

  @override
  TiposMantenimientoRow createRow(Map<String, dynamic> data) =>
      TiposMantenimientoRow(data);
}

class TiposMantenimientoRow extends SupabaseDataRow {
  TiposMantenimientoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TiposMantenimientoTable();

  String get codigo => getField<String>('codigo')!;
  set codigo(String value) => setField<String>('codigo', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  String get categoria => getField<String>('categoria')!;
  set categoria(String value) => setField<String>('categoria', value);
}
