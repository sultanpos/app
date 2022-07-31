import 'package:sultanpos/state/base.dart';

class ProductState extends BaseState {
  ProductState(super.httpAPI);

  int currentIndex = 0;

  setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
