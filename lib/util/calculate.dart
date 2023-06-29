int calculateDiscount(int value, String formula) {
  if (formula.isEmpty) return 0;
  final l = formula.split('+');
  int total = 0;
  int rest = value;
  for (int i = 0; i < l.length; i++) {
    final v = l[i].trim();
    if (v.endsWith('%')) {
      final discStr = v.replaceAll('%', '');
      final discVal = int.tryParse(discStr);
      if (discVal == null) continue;
      final disc = discVal * rest ~/ 100;
      total += disc;
      rest -= disc;
    } else {
      final disc = int.tryParse(v);
      if (disc == null) continue;
      total += disc;
      rest -= disc;
    }
  }
  return total;
}

double calculateMargin(int buy, int sell) {
  final diff = (sell - buy).toDouble();
  if (buy == 0) return 0;
  return diff * 100.0 / buy.toDouble();
}

int rawCalculateTotal(int amount, int price, String discountFormula) {
  int newPrice = price - calculateDiscount(price, discountFormula);
  return (newPrice * amount) ~/ 1000;
}
