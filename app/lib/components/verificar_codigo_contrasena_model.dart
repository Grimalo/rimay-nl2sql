import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'verificar_codigo_contrasena_widget.dart'
    show VerificarCodigoContrasenaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificarCodigoContrasenaModel
    extends FlutterFlowModel<VerificarCodigoContrasenaWidget> {
  ///  Local state fields for this component.

  bool errorCodigo = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for codigoContrasena widget.
  FocusNode? codigoContrasenaFocusNode;
  TextEditingController? codigoContrasenaTextController;
  String? Function(BuildContext, String?)?
      codigoContrasenaTextControllerValidator;
  // Stores action output result for [Custom Action - verificarCodigo] action in Button widget.
  String? resultadoVerificacion;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    codigoContrasenaFocusNode?.dispose();
    codigoContrasenaTextController?.dispose();
  }
}
