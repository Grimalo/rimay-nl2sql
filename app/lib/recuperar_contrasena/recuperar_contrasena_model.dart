import '/components/verificar_codigo_contrasena_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'recuperar_contrasena_widget.dart' show RecuperarContrasenaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecuperarContrasenaModel
    extends FlutterFlowModel<RecuperarContrasenaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for codigo widget.
  FocusNode? codigoFocusNode;
  TextEditingController? codigoTextController;
  String? Function(BuildContext, String?)? codigoTextControllerValidator;
  // Stores action output result for [Custom Action - enviarCodigoRecuperacion] action in Button-Code widget.
  String? resultadoEnvio;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    codigoFocusNode?.dispose();
    codigoTextController?.dispose();
  }
}
