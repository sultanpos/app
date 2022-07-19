import 'package:flutter/material.dart';

class StateAuth extends ChangeNotifier {
  bool loggedIn = false;
  String? accessToken;
  String? refreshToken;

  void setLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }

  void setToken(String? accessToken, String? refreshToken) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  void reset() {
    loggedIn = false;
    accessToken = null;
    refreshToken = null;
    notifyListeners();
  }
}
