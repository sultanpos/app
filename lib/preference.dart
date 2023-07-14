import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultanpos/model/appconfig.dart';
import 'package:sultanpos/model/auth.dart';

class Preference {
  static final Preference _singleton = Preference._internal();

  factory Preference() {
    return _singleton;
  }

  Preference._internal();

  late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final folderPath = await getApplicationSupportDirectory();
    debugPrint("shared preference location: ${folderPath.path}");
  }

  storeAuth(LoginResponse token) {
    return sharedPreferences.setString('token', jsonEncode(token.toJson()));
  }

  LoginResponse? getToken() {
    final val = sharedPreferences.getString('token');
    if (val == null || val == '') return null;
    final json = jsonDecode(val);
    return LoginResponse.fromJson(json);
  }

  resetLogin() {
    sharedPreferences.remove('token');
  }

  Map<String, double> getTableWidth(String key) {
    final value = sharedPreferences.getString('table-$key');
    if (value != null) {
      return (jsonDecode(value) as Map<String, dynamic>).map((key, value) => MapEntry(key, (value as num).toDouble()));
    }
    return {};
  }

  saveTableWidth(String key, Map<String, double> data) {
    final str = jsonEncode(data);
    sharedPreferences.setString('table-$key', str);
  }

  AppConfigPrinter? getDefaultPrinter() {
    final jsonString = sharedPreferences.getString("defaultPrinter");
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }
    return AppConfigPrinter.fromJsonString(jsonString);
  }

  setDefaultPrinter(AppConfigPrinter model) {
    return sharedPreferences.setString("defaultPrinter", model.toJsonString());
  }
}
