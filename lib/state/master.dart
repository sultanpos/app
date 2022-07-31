import 'package:sultanpos/state/base.dart';

class MasterState extends BaseState {
  MasterState(super.httpAPI);
  int currentIndex = 0;

  setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
