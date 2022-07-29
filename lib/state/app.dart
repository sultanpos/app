import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/state/auth.dart';

class AppState {
  AuthState? authState;

  init(HttpAPI httpAPI) async {
    authState = AuthState(httpAPI);
  }
}
