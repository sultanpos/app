import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sultanpos/app.dart';
import 'package:sultanpos/flavor.dart';
import 'package:sultanpos/http/authinterceptor.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/preference.dart';
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

  init() async {
    await Preference().init();
    final interceptor = AuthInterceptor(Dio(BaseOptions(baseUrl: Flavor.baseUrl!)), "/auth/login/refresh", storeAccessToken: _tokenRefreshed);
    final httpAPI = HttpAPI.create(Flavor.baseUrl!, interceptor);
    authState = AuthState(httpAPI);
    navState = NavigationState();
    await AppState().authState!.loadLogin();
  }

  _tokenRefreshed(LoginResponse token) {
    Preference().storeAuth(token.normalizeDate());
  }
}
