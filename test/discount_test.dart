import 'package:sultanpos/util/calculate.dart';
import 'package:test/test.dart';

class Value {
  final int value;
  final String formula;
  final int result;
  Value(this.value, this.formula, this.result);
}

void main() {
  test('Discount formula', () async {
    final values = [
      Value(1000, "100", 100),
      Value(1000, "100a", 0),
      Value(1000, "10%", 100),
      Value(1000, "100+100", 200),
      Value(1000, "100+10 % ", 190),
      Value(1000, "10% + 10% ", 190),
      Value(1000, "10 % + 10 % ", 190),
      Value(1000, "20% + 20%", 360),
      Value(1000, "20aa% + 20%", 200),
      Value(1000, "20%ab + 20%", 200),
    ];
    // ignore: avoid_function_literals_in_foreach_calls
    values.forEach((element) {
      final result = calculateDiscount(element.value, element.formula);
      expect(result, element.result);
    });
  });
}
