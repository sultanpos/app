import 'package:flutter/material.dart';

class MasterState extends ChangeNotifier {
  MasterState();
  String? currentId;

  setCurrentId(String value) {
    currentId = value;
    notifyListeners();
  }
}
