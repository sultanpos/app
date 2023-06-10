import 'package:sultanpos/state/base.dart';

class MasterState extends BaseState {
  MasterState();
  String? currentId;

  setCurrentId(String value) {
    currentId = value;
    notifyListeners();
  }
}
