import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultanpos/model/auth.dart';

class Preference {
  static final Preference _singleton = Preference._internal();

  factory Preference() {
    return _singleton;
  }

  Preference._internal();

  SharedPreferences? sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  storeAuth(LoginResponse token) {
    return sharedPreferences!.setString('token', jsonEncode(token.toJson()));
  }

  LoginResponse? getToken() {
    final val = sharedPreferences!.getString('token');
    if (val == null || val == '') return null;
    final json = jsonDecode(val);
    return LoginResponse.fromJson(json);
  }

  resetLogin() {
    sharedPreferences!.remove('token');
  }
}
