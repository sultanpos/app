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
