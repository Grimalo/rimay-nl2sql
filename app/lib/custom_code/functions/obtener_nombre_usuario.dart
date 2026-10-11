import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String? obtenerNombreUsuario() {
  final user = SupaFlow.client.auth.currentUser;
  if (user == null) return null;
  final metadata = user.userMetadata;
  final firstName = metadata?['first_name'] as String?;
  final lastName = metadata?['last_name'] as String?;
  if (firstName != null && firstName.isNotEmpty) {
    if (lastName != null && lastName.isNotEmpty) {
      return '$firstName $lastName';
    }
    return firstName;
  }
  return user.email;
}
