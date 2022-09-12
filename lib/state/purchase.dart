import 'package:sultanpos/state/base.dart';

class PurchaseTabItem {
  final String id;
  final String title;
  PurchaseTabItem(this.id, this.title);
}

class PurchaseState extends BaseState {
  PurchaseState(super.httpAPI);

  String? currentId;
  List<PurchaseTabItem> tabs = [];

  setCurrentId(String curId) {
    currentId = curId;
    notifyListeners();
  }

  addNewTab(PurchaseTabItem item) {
    final index = tabs.indexWhere((element) => element.id == item.id);
    if (index < 0) tabs.add(item);
    currentId = item.id;
    notifyListeners();
  }

  closeTab(String id) {
    final index = tabs.indexWhere((element) => element.id == id);
    final nextIndex = index - 1;
    tabs.removeAt(index);
    currentId = nextIndex < 0 ? null : tabs[nextIndex].id;
    notifyListeners();
  }
}
