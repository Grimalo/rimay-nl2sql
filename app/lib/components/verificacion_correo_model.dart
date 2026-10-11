import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'verificacion_correo_widget.dart' show VerificacionCorreoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificacionCorreoModel
    extends FlutterFlowModel<VerificacionCorreoWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - iniciarSesion] action in Button widget.
  String? resultadoLogin;
  // Stores action output result for [Custom Action - reenviarVerificacion] action in Text widget.
  String? resultadoReenvio;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
