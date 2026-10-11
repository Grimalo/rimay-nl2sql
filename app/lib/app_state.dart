import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _idDispositivo = prefs.getString('ff_idDispositivo') ?? _idDispositivo;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _idDispositivo = '';
  String get idDispositivo => _idDispositivo;
  set idDispositivo(String value) {
    _idDispositivo = value;
    prefs.setString('ff_idDispositivo', value);
  }

  String _idConversacion = '';
  String get idConversacion => _idConversacion;
  set idConversacion(String value) {
    _idConversacion = value;
  }

  String _tituloConversacion = '';
  String get tituloConversacion => _tituloConversacion;
  set tituloConversacion(String value) {
    _tituloConversacion = value;
  }

  List<MensajeChatStruct> _mensajes = [];
  List<MensajeChatStruct> get mensajes => _mensajes;
  set mensajes(List<MensajeChatStruct> value) {
    _mensajes = value;
  }

  void addToMensajes(MensajeChatStruct value) {
    mensajes.add(value);
  }

  void removeFromMensajes(MensajeChatStruct value) {
    mensajes.remove(value);
  }

  void removeAtIndexFromMensajes(int index) {
    mensajes.removeAt(index);
  }

  void updateMensajesAtIndex(
    int index,
    MensajeChatStruct Function(MensajeChatStruct) updateFn,
  ) {
    mensajes[index] = updateFn(_mensajes[index]);
  }

  void insertAtIndexInMensajes(int index, MensajeChatStruct value) {
    mensajes.insert(index, value);
  }

  bool _enviando = false;
  bool get enviando => _enviando;
  set enviando(bool value) {
    _enviando = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
