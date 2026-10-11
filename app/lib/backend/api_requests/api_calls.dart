import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Chatbot Group Code

class ChatbotGroup {
  static String getBaseUrl() =>
      'https://TU_PROYECTO.supabase.co/functions/v1';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
  };
  static EnviarPreguntaCall enviarPreguntaCall = EnviarPreguntaCall();
  static ListarConversacionesCall listarConversacionesCall =
      ListarConversacionesCall();
  static LeerConversacionCall leerConversacionCall = LeerConversacionCall();
  static RenombrarConversacionCall renombrarConversacionCall =
      RenombrarConversacionCall();
  static EliminarConversacionCall eliminarConversacionCall =
      EliminarConversacionCall();
}

class EnviarPreguntaCall {
  Future<ApiCallResponse> call({
    String? pregunta = '',
    String? idDispositivo = '',
    String? idConversacion = '',
  }) async {
    final baseUrl = ChatbotGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "pregunta": ${pregunta == null ? 'null' : '"${escapeStringForJson(pregunta)}"'},
  "id_dispositivo": ${idDispositivo == null ? 'null' : '"${escapeStringForJson(idDispositivo)}"'},
  "id_conversacion": ${idConversacion == null ? 'null' : '"${escapeStringForJson(idConversacion)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'enviarPregunta',
      apiUrl: '${baseUrl}/consulta',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListarConversacionesCall {
  Future<ApiCallResponse> call({
    String? idDispositivo = '',
  }) async {
    final baseUrl = ChatbotGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "accion": "listar_conversaciones",
  "id_dispositivo": ${idDispositivo == null ? 'null' : '"${escapeStringForJson(idDispositivo)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'listarConversaciones',
      apiUrl: '${baseUrl}/consulta',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LeerConversacionCall {
  Future<ApiCallResponse> call({
    String? idDispositivo = '',
    String? idConversacion = '',
  }) async {
    final baseUrl = ChatbotGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "accion": "leer_conversacion",
  "id_dispositivo": ${idDispositivo == null ? 'null' : '"${escapeStringForJson(idDispositivo)}"'},
  "id_conversacion": ${idConversacion == null ? 'null' : '"${escapeStringForJson(idConversacion)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'leerConversacion',
      apiUrl: '${baseUrl}/consulta',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RenombrarConversacionCall {
  Future<ApiCallResponse> call({
    String? idDispositivo = '',
    String? idConversacion = '',
    String? titulo = '',
  }) async {
    final baseUrl = ChatbotGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "accion": "renombrar_conversacion",
  "id_dispositivo": ${idDispositivo == null ? 'null' : '"${escapeStringForJson(idDispositivo)}"'},
  "id_conversacion": ${idConversacion == null ? 'null' : '"${escapeStringForJson(idConversacion)}"'},
  "titulo": ${titulo == null ? 'null' : '"${escapeStringForJson(titulo)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'renombrarConversacion',
      apiUrl: '${baseUrl}/consulta',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EliminarConversacionCall {
  Future<ApiCallResponse> call({
    String? idDispositivo = '',
    String? idConversacion = '',
  }) async {
    final baseUrl = ChatbotGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "accion": "eliminar_conversacion",
  "id_dispositivo": ${idDispositivo == null ? 'null' : '"${escapeStringForJson(idDispositivo)}"'},
  "id_conversacion": ${idConversacion == null ? 'null' : '"${escapeStringForJson(idConversacion)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'eliminarConversacion',
      apiUrl: '${baseUrl}/consulta',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey': 'TU_SUPABASE_PUBLISHABLE_KEY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Chatbot Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  final encoded = jsonEncode(input);
  return encoded.substring(1, encoded.length - 1);
}
