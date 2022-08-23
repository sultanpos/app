import 'package:sultanpos/format.dart';
import 'package:test/test.dart';

class StockValue {
  final int value;
  final String result;
  StockValue(this.value, this.result);
}

class MoneyValue {
  final int value;
  final String result;
  MoneyValue(this.value, this.result);
}

void main() {
  Format().setup(locale: "id");
  test('Stock format test', () async {
    final stocks = [
      StockValue(1000, "1"),
      StockValue(1230, "1,23"),
      StockValue(1234, "1,234"),
      StockValue(1234000, "1.234"),
    ];
    // ignore: avoid_function_literals_in_foreach_calls
    stocks.forEach((element) {
      final result = Format().formatStock(element.value);
      expect(result, element.result);
    });
  });
  test('Money format test', () async {
    final moneis = [
      StockValue(1000, "1.000"),
      StockValue(1234, "1.234"),
      StockValue(1234000, "1.234.000"),
    ];
    // ignore: avoid_function_literals_in_foreach_calls
    moneis.forEach((element) {
      final result = Format().formatMoney(element.value);
      expect(result, element.result);
    });
  });
}
