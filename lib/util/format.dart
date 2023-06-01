import 'package:intl/intl.dart';

String formatMoney(int value) {
  return NumberFormat.decimalPattern('id').format(value);
}

String formatMoneyDouble(double value) {
  return NumberFormat.decimalPattern('id').format(value);
}

String formatDate(DateTime? date) {
  if (date == null) return "";
  final df = DateFormat("d-M-y", "id");
  return df.format(date);
}

String formatDateTime(DateTime? date) {
  if (date == null) return "";
  final df = DateFormat("d-M-y h:m", "id");
  return df.format(date);
}

int moneyValue(String val) {
  if (val.isEmpty) return 0;
  final normalize = val.replaceAll('.', '').replaceAll(',', '.');
  return int.parse(normalize);
}

int stockValue(String val) {
  final normalize = val.replaceAll('.', '').replaceAll(',', '.');
  final doubleVal = double.tryParse(normalize);
  if (doubleVal != null) {
    return (doubleVal * 1000.0).toInt();
  }
  return 0;
}
