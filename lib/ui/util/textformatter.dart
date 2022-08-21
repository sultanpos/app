import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MoneyTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final normalized = newValue.text.replaceAll(".", "");
    final intVal = int.tryParse(normalized) ?? 0;
    final formatted = NumberFormat.decimalPattern('id').format(intVal);
    return TextEditingValue(
      text: formatted,
      selection: newValue.selection.copyWith(baseOffset: formatted.length, extentOffset: formatted.length),
    );
  }
}
