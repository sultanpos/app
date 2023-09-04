import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultanpos/model/appconfig.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/branch.dart';

class Preference {
  static final Preference _singleton = Preference._internal();

  static const String keyShouldCheckLocal = "shouldCacheToLocal";
  static const String keyBranch = "branch";
  static const String keyDefaultPrinter = "defaultPrinter";
  static const String keyScale = "scale";

  factory Preference() {
    return _singleton;
  }

  Preference._internal();

  late SharedPreferences sharedPreferences;
  final StreamController<String> _streamController = StreamController<String>.broadcast();

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
    final jsonString = sharedPreferences.getString(keyDefaultPrinter);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }
    return AppConfigPrinter.fromJsonString(jsonString);
  }

  setDefaultPrinter(AppConfigPrinter model) async {
    await sharedPreferences
        .setString(keyDefaultPrinter, model.toJsonString())
        .then((value) => _streamController.add(keyDefaultPrinter));
  }

  saveBranch(BranchModel? branch) async {
    if (branch == null) {
      await sharedPreferences.remove(keyBranch).then((value) => _streamController.add(keyBranch));
    } else {
      await sharedPreferences
          .setString(keyBranch, jsonEncode(branch.toJson()))
          .then((value) => _streamController.add(keyBranch));
    }
  }

  BranchModel? getBranch() {
    final branchJsonString = sharedPreferences.getString(keyBranch);
    if (branchJsonString == null || branchJsonString == "") {
      return null;
    }
    return BranchModel.fromJson(jsonDecode(branchJsonString));
  }

  bool? shouldCacheToLocal() {
    return sharedPreferences.getBool(keyShouldCheckLocal);
  }

  setShouldCacheToLocal(bool value) async {
    await sharedPreferences
        .setBool(keyShouldCheckLocal, value)
        .then((value) => _streamController.add(keyShouldCheckLocal));
  }

  setScale(double scale) {
    return sharedPreferences.setDouble(keyScale, scale);
  }

  double scale() {
    return sharedPreferences.getDouble(keyScale) ?? 1;
  }

  listen(Function(String msg)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _streamController.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
