import 'package:flutter/services.dart';

extension KeyPressedKeyEvent on KeyEvent {
  bool isPressed(LogicalKeyboardKey key, {bool isCtrl = false, bool isAlt = false, bool isShift = false}) {
    if (isCtrl && !HardwareKeyboard.instance.isControlPressed) return false;
    if (isAlt && !HardwareKeyboard.instance.isAltPressed) return false;
    if (isShift && !HardwareKeyboard.instance.isShiftPressed) return false;
    return key == logicalKey;
  }
}
