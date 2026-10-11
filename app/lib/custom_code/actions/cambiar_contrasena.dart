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

Future<String> cambiarContrasena(String nuevaPassword) async {
  try {
    await SupaFlow.client.auth
        .updateUser(UserAttributes(password: nuevaPassword));
    await SupaFlow.client.auth.signOut();
    return 'ok';
  } on AuthException catch (e) {
    return e.message;
  }
}
