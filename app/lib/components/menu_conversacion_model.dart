import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import 'menu_conversacion_widget.dart' show MenuConversacionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuConversacionModel extends FlutterFlowModel<MenuConversacionWidget> {
  ///  Local state fields for this component.

  String modo = 'menu';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (eliminarConversacion)] action in filaEliminar widget.
  ApiCallResponse? apiResultt3v;
  // State field(s) for campoTitulo widget.
  FocusNode? campoTituloFocusNode;
  TextEditingController? campoTituloTextController;
  String? Function(BuildContext, String?)? campoTituloTextControllerValidator;
  // Stores action output result for [Backend Call - API (renombrarConversacion)] action in botonGuardar widget.
  ApiCallResponse? apiResulteww;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    campoTituloFocusNode?.dispose();
    campoTituloTextController?.dispose();
  }
}
