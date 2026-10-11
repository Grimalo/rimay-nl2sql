// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MensajeChatStruct extends BaseStruct {
  MensajeChatStruct({
    String? rol,
    String? texto,
    String? sql,
    String? estado,
  })  : _rol = rol,
        _texto = texto,
        _sql = sql,
        _estado = estado;

  // "rol" field.
  String? _rol;
  String get rol => _rol ?? '';
  set rol(String? val) => _rol = val;

  bool hasRol() => _rol != null;

  // "texto" field.
  String? _texto;
  String get texto => _texto ?? '';
  set texto(String? val) => _texto = val;

  bool hasTexto() => _texto != null;

  // "sql" field.
  String? _sql;
  String get sql => _sql ?? '';
  set sql(String? val) => _sql = val;

  bool hasSql() => _sql != null;

  // "estado" field.
  String? _estado;
  String get estado => _estado ?? '';
  set estado(String? val) => _estado = val;

  bool hasEstado() => _estado != null;

  static MensajeChatStruct fromMap(Map<String, dynamic> data) =>
      MensajeChatStruct(
        rol: data['rol'] as String?,
        texto: data['texto'] as String?,
        sql: data['sql'] as String?,
        estado: data['estado'] as String?,
      );

  static MensajeChatStruct? maybeFromMap(dynamic data) => data is Map
      ? MensajeChatStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'rol': _rol,
        'texto': _texto,
        'sql': _sql,
        'estado': _estado,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'rol': serializeParam(
          _rol,
          ParamType.String,
        ),
        'texto': serializeParam(
          _texto,
          ParamType.String,
        ),
        'sql': serializeParam(
          _sql,
          ParamType.String,
        ),
        'estado': serializeParam(
          _estado,
          ParamType.String,
        ),
      }.withoutNulls;

  static MensajeChatStruct fromSerializableMap(Map<String, dynamic> data) =>
      MensajeChatStruct(
        rol: deserializeParam(
          data['rol'],
          ParamType.String,
          false,
        ),
        texto: deserializeParam(
          data['texto'],
          ParamType.String,
          false,
        ),
        sql: deserializeParam(
          data['sql'],
          ParamType.String,
          false,
        ),
        estado: deserializeParam(
          data['estado'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MensajeChatStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MensajeChatStruct &&
        rol == other.rol &&
        texto == other.texto &&
        sql == other.sql &&
        estado == other.estado;
  }

  @override
  int get hashCode => const ListEquality().hash([rol, texto, sql, estado]);
}

MensajeChatStruct createMensajeChatStruct({
  String? rol,
  String? texto,
  String? sql,
  String? estado,
}) =>
    MensajeChatStruct(
      rol: rol,
      texto: texto,
      sql: sql,
      estado: estado,
    );
