import 'package:sultanpos/state/base.dart';

class MasterState extends BaseState {
  MasterState(super.httpAPI);
  String? currentId;

  setCurrentId(String value) {
    currentId = value;
    notifyListeners();
  }
}
