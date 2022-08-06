import 'package:flutter/material.dart';

lighterOrDarkerColor(ThemeData theme, Color color, {double amount = .04}) {
  final bool darkMode = theme.brightness == Brightness.dark;
  final hslColor = HSLColor.fromColor(color);
  final lightness = !darkMode ? hslColor.lightness + amount : hslColor.lightness - amount;
  return hslColor.withLightness(lightness).toColor();
}
