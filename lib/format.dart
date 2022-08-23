import 'package:intl/intl.dart';

class Format {
  static final Format _singleton = Format._internal();

  factory Format() {
    return _singleton;
  }

  Format._internal();

  late String locale;
  late NumberFormat stockFormat;
  late NumberFormat moneyFormat;

  setup({required String locale}) {
    this.locale = locale;
    stockFormat = NumberFormat.simpleCurrency(locale: locale, decimalDigits: 3, name: "");
    moneyFormat = NumberFormat.decimalPattern(locale);
  }

  String formatStock(int stock) {
    final doubleValue = stock.toDouble() / 1000.0;
    var res = stockFormat.format(doubleValue);
    for (int i = 0; i < 3; i++) {
      if (res.endsWith("0")) {
        res = res.substring(0, i == 2 ? res.length - 2 : res.length - 1);
      }
    }
    return res;
  }

  String formatMoney(int value) {
    return moneyFormat.format(value);
  }
}
