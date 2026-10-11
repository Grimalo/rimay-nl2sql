import '/backend/api_requests/api_manager.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

Future reiniciarChat(BuildContext context) async {
  FFAppState().mensajes = [];
  FFAppState().idConversacion = '';
  FFAppState().tituloConversacion = '';
  FFAppState().enviando = false;
  FFAppState().addToMensajes(MensajeChatStruct(
    rol: 'asistente',
    texto:
        '¡Hola, soy Rimay! Consulto el inventario y el historial de mantenimiento de los equipos biomédicos del HNERM. Dime en qué te puedo ayudar.',
    estado: 'SALUDO',
  ));
}
