import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/localfiledb/db.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/crud.dart';

class PurchaseTabItem {
  final String id;
  final String title;
  PurchaseTabItem(this.id, this.title);
}

class PurchaseEditState extends ChangeNotifier {
  final String id;
  String title;
  PurchaseModel? purchase;
  late bool local;
  bool loading = true;
  late FormGroup form;

  PurchaseEditState(this.id, {this.purchase, required this.title}) {
    form = FormGroup({
      'number': FormControl<String>(validators: [Validators.required], touched: true),
      //'branchPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'partnerId': FormControl<int>(validators: [Validators.required], touched: true),
      'type': FormControl<String>(value: 'direct', validators: [Validators.required], touched: true),
      'deadline': FormControl<DateTime>()
    });
  }

  factory PurchaseEditState.fromLocal(PurchaseModel data) {
    final state = PurchaseEditState('${data.id}', purchase: data, title: 'Baru');
    state.loading = false;
    state.local = true;
    return state;
  }

  init(bool newRecord) async {
    if (newRecord) {
      local = true;
      purchase = PurchaseModel(int.parse(id), '', 'direct', 'draft', 0, '', 0, 0, 0, 0, null, null, null);
      await LocalFileDb().purchase.save(purchase!);
    }
  }

  remove() {
    if (local) {
      LocalFileDb().purchase.deleteById(purchase!.getId());
    }
  }
}

class PurchaseState extends CrudState<PurchaseModel> {
  PurchaseState(super.httpAPI) : super(path: '/purchase', creator: PurchaseModel.fromJson) {
    form = FormGroup({});
  }

  String? currentId;
  List<PurchaseEditState> items = [];

  init() async {
    final pending = await LocalFileDb().purchase.getAll();
    for (int i = 0; i < pending.length; i++) {
      final purchaseState = PurchaseEditState.fromLocal(pending[i]);
      items.add(purchaseState);
    }
  }

  setCurrentId(String curId) {
    currentId = curId;
    notifyListeners();
  }

  addNewTab(String id, String title, bool newRecord) {
    final index = items.indexWhere((element) => element.id == id);
    final purchase = PurchaseEditState(id, title: title);
    if (index < 0) items.add(purchase);
    currentId = id;
    notifyListeners();
    purchase.init(newRecord);
  }

  closeTab(String id) {
    final index = items.indexWhere((element) => element.id == id);
    final purchaseState = items[index];
    items.removeAt(index);
    currentId = items.isEmpty
        ? null
        : index >= items.length
            ? items[index - 1].id
            : items[index].id;
    purchaseState.remove();
    notifyListeners();
  }

  PurchaseEditState getPurchaseEditState(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  @override
  prepareEditForm(PurchaseModel value) {}

  @override
  BaseModel prepareInsertModel() {
    throw UnimplementedError();
  }

  @override
  BaseModel prepareUpdateModel() {
    throw UnimplementedError();
  }
}
