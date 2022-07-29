import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/state/base.dart';

class AuthState extends BaseState {
  JWTClaim? claim;

  AuthState(HttpAPI httpAPI) : super(httpAPI);

  final loginForm = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  login() async {
    if (loginForm.valid) {}
  }

  setLoggedIn(JWTClaim? claim) {
    claim = claim;
    notifyListeners();
  }

  logout() {
    claim = null;
    notifyListeners();
  }
}
