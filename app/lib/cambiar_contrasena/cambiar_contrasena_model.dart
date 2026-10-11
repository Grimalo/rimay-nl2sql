import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'cambiar_contrasena_widget.dart' show CambiarContrasenaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CambiarContrasenaModel extends FlutterFlowModel<CambiarContrasenaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for actualPassword widget.
  FocusNode? actualPasswordFocusNode;
  TextEditingController? actualPasswordTextController;
  late bool actualPasswordVisibility;
  String? Function(BuildContext, String?)?
      actualPasswordTextControllerValidator;
  // State field(s) for nuevaPassword widget.
  FocusNode? nuevaPasswordFocusNode;
  TextEditingController? nuevaPasswordTextController;
  late bool nuevaPasswordVisibility;
  String? Function(BuildContext, String?)? nuevaPasswordTextControllerValidator;
  // State field(s) for confirmarPassword widget.
  FocusNode? confirmarPasswordFocusNode;
  TextEditingController? confirmarPasswordTextController;
  late bool confirmarPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmarPasswordTextControllerValidator;
  // Stores action output result for [Custom Action - cambiarContrasenaConVerificacion] action in Button-Code widget.
  String? resultadoCambio;

  @override
  void initState(BuildContext context) {
    actualPasswordVisibility = false;
    nuevaPasswordVisibility = false;
    confirmarPasswordVisibility = false;
  }

  @override
  void dispose() {
    actualPasswordFocusNode?.dispose();
    actualPasswordTextController?.dispose();

    nuevaPasswordFocusNode?.dispose();
    nuevaPasswordTextController?.dispose();

    confirmarPasswordFocusNode?.dispose();
    confirmarPasswordTextController?.dispose();
  }
}
