import 'package:flutter/services.dart';

abstract class KeyName {
  static final Map<String, String> _keyMapName = {'Escape': 'Esc'};
  static String? getFirstName(List<LogicalKeyboardKey>? shortCut) {
    if (shortCut == null) return null;
    if (shortCut.isEmpty) return null;
    final rawKeyName = shortCut.first.keyLabel;
    if (_keyMapName.containsKey(rawKeyName)) return _keyMapName[rawKeyName];
    return rawKeyName;
  }
}
