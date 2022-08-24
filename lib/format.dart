import 'package:intl/intl.dart';

class Format {
  static final Format _singleton = Format._internal();

  factory Format() {
    return _singleton;
  }

  Format._internal();

  late String locale;
  late NumberFormat _stockFormat;
  late NumberFormat _moneyFormat;
  late NumberFormat _percFormat;

  setup({required String locale}) {
    this.locale = locale;
    _stockFormat = NumberFormat.simpleCurrency(locale: locale, decimalDigits: 3, name: "");
    _percFormat = NumberFormat.simpleCurrency(locale: locale, decimalDigits: 2, name: "");
    _moneyFormat = NumberFormat.decimalPattern(locale);
  }

  String formatStock(int stock) {
    final doubleValue = stock.toDouble() / 1000.0;
    var res = _stockFormat.format(doubleValue);
    for (int i = 0; i < 3; i++) {
      if (res.endsWith("0")) {
        res = res.substring(0, i == 2 ? res.length - 2 : res.length - 1);
      }
    }
    return res;
  }

  String formatMoney(int value) {
    return _moneyFormat.format(value);
  }

  String formatPerc(double value) {
    return _percFormat.format(value);
  }
}
