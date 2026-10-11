import '../database.dart';

class EquiposTable extends SupabaseTable<EquiposRow> {
  @override
  String get tableName => 'equipos';

  @override
  EquiposRow createRow(Map<String, dynamic> data) => EquiposRow(data);
}

class EquiposRow extends SupabaseDataRow {
  EquiposRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EquiposTable();

  String get codigoPatrimonial => getField<String>('codigo_patrimonial')!;
  set codigoPatrimonial(String value) =>
      setField<String>('codigo_patrimonial', value);

  int get idTipoEquipo => getField<int>('id_tipo_equipo')!;
  set idTipoEquipo(int value) => setField<int>('id_tipo_equipo', value);

  String get cobertura => getField<String>('cobertura')!;
  set cobertura(String value) => setField<String>('cobertura', value);
}
