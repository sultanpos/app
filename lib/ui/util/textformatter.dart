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

class StockTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    bool endWithDot = false;
    String value = newValue.text;
    if (value.endsWith('.')) {
      value = '${value.substring(0, value.length - 1)},';
    }
    if (value.endsWith(",")) {
      final idx = value.indexOf(',');
      if (idx != value.length - 1) {
        value = value.substring(0, value.length - 1);
      } else {
        endWithDot = true;
      }
    }
    String normalized = value.replaceAll(".", "").replaceAll(',', '.');
    final doubleVal = double.tryParse(normalized) ?? 0;
    final formatted = endWithDot ? '${NumberFormat.decimalPattern('id').format(doubleVal)},' : NumberFormat.decimalPattern('id').format(doubleVal);
    return TextEditingValue(
      text: formatted,
      selection: newValue.selection.copyWith(baseOffset: formatted.length, extentOffset: formatted.length),
    );
  }
}

String formatMoney(int value) {
  return NumberFormat.decimalPattern('id').format(value);
}

String formatMoneyDouble(double value) {
  return NumberFormat.decimalPattern('id').format(value);
}
