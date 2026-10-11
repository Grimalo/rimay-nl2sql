import '../database.dart';

class EjecutoresTable extends SupabaseTable<EjecutoresRow> {
  @override
  String get tableName => 'ejecutores';

  @override
  EjecutoresRow createRow(Map<String, dynamic> data) => EjecutoresRow(data);
}

class EjecutoresRow extends SupabaseDataRow {
  EjecutoresRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EjecutoresTable();

  int get idEjecutor => getField<int>('id_ejecutor')!;
  set idEjecutor(int value) => setField<int>('id_ejecutor', value);

  String get razonSocial => getField<String>('razon_social')!;
  set razonSocial(String value) => setField<String>('razon_social', value);
}
