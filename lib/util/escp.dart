import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class Escp {
  final Generator _generator;
  final PaperSize _paperSize;
  List<int> _data = [];
  get data {
    return _data;
  }

  Escp(PaperSize paperSize, CapabilityProfile profile)
      : _paperSize = paperSize,
        _generator = Generator(paperSize, profile);

  int _paperWidth() {
    return _paperSize == PaperSize.mm58 ? 32 : 64;
  }

  Escp style(PosStyles style) {
    _data += _generator.setStyles(style);
    return this;
  }

  Escp text(String text, {PosStyles? style}) {
    _data += _generator.text(text, styles: style ?? const PosStyles());
    return this;
  }

  Escp leftRight(String left, String right, {PosStyles? style}) {
    return text(_leftRightText(left, right), style: style);
  }

  Escp hr() {
    _data += _generator.hr();
    return this;
  }

  String _leftRightText(String left, String right) {
    final width = _paperWidth();
    final length = left.length + right.length;
    if (length > width) {
      return "${left.substring(0, (width - right.length - 1))} $right";
    }
    return "$left${right.padLeft(width - length + right.length)}";
  }

  Escp feed([int number = 1]) {
    _data += _generator.feed(number);
    return this;
  }

  Escp openDrawer() {
    _data += _generator.drawer();
    return this;
  }
}
