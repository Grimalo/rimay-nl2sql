// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

Future<String> cambiarContrasenaConVerificacion(
    String contrasenaActual, String contrasenaNueva) async {
  try {
    final email = SupaFlow.client.auth.currentUser?.email;
    if (email == null) {
      return 'SIN_SESION';
    }
    try {
      await SupaFlow.client.auth
          .signInWithPassword(email: email, password: contrasenaActual);
    } on AuthException catch (_) {
      return 'CONTRASENA_ACTUAL_INCORRECTA';
    }
    await SupaFlow.client.auth
        .updateUser(UserAttributes(password: contrasenaNueva));
    await SupaFlow.client.auth.signOut();
    return 'ok';
  } on AuthException catch (e) {
    return e.message;
  }
}
