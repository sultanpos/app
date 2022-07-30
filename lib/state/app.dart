import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/state/auth.dart';
import 'package:sultanpos/state/navigation.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  AuthState? authState;
  NavigationState? navState;

  init(HttpAPI httpAPI) async {
    authState = AuthState(httpAPI);
    navState = NavigationState();
  }
}
