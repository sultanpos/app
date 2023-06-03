import 'package:flutter/material.dart';

class STheme {
  static final STheme _singleton = STheme._internal();

  factory STheme() {
    return _singleton;
  }

  STheme._internal();

  late InputDecoration defInputDecoration;
  late double widgetSpace;
  late double buttonHeight;
  late double padding;

  init() {
    widgetSpace = 16;
    buttonHeight = 40;
    padding = 8;
    defInputDecoration = const InputDecoration(
      isDense: true,
      filled: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.all(12),
      errorStyle: TextStyle(height: 0.3),
    );
  }
}
