import '../database.dart';

class TiposEquipoTable extends SupabaseTable<TiposEquipoRow> {
  @override
  String get tableName => 'tipos_equipo';

  @override
  TiposEquipoRow createRow(Map<String, dynamic> data) => TiposEquipoRow(data);
}

class TiposEquipoRow extends SupabaseDataRow {
  TiposEquipoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TiposEquipoTable();

  int get idTipoEquipo => getField<int>('id_tipo_equipo')!;
  set idTipoEquipo(int value) => setField<int>('id_tipo_equipo', value);

  String get denominacion => getField<String>('denominacion')!;
  set denominacion(String value) => setField<String>('denominacion', value);
}
