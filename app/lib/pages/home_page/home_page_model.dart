import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/menu_conversacion_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for listaConversaciones widget.
  ScrollController? listaConversacionesScrollController;
  // Stores action output result for [Backend Call - API (leerConversacion)] action in Container widget.
  ApiCallResponse? respLeer;
  // State field(s) for scrollMensajes widget.
  ScrollController? scrollMensajesScrollController;
  // State field(s) for listaMensajes widget.
  ScrollController? listaMensajesScrollController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (enviarPregunta)] action in IconButton widget.
  ApiCallResponse? apiResultyja;

  @override
  void initState(BuildContext context) {
    listaConversacionesScrollController = ScrollController();
    scrollMensajesScrollController = ScrollController();
    listaMensajesScrollController = ScrollController();
  }

  @override
  void dispose() {
    listaConversacionesScrollController?.dispose();
    scrollMensajesScrollController?.dispose();
    listaMensajesScrollController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
