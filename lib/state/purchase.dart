import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/app.dart';

import 'package:sultanpos/state/crud.dart';

class PurchaseTabItem {
  final String id;
  final String title;
  PurchaseTabItem(this.id, this.title);
}

class PurchaseState extends CrudState<PurchaseModel> {
  PurchaseState(super.httpAPI) : super(path: '/purchase', creator: PurchaseModel.fromJson) {
    form = FormGroup({
      'number': FormControl<String>(validators: [Validators.required], touched: true),
      //'branchPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'partnerPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'type': FormControl<String>(value: 'direct', validators: [Validators.required], touched: true),
      'deadline': FormControl<DateTime>()
    });
  }

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
    tabs.removeAt(index);
    currentId = tabs.isEmpty
        ? null
        : index >= tabs.length
            ? tabs[index - 1].id
            : tabs[index].id;
    notifyListeners();
  }

  @override
  prepareEditForm(PurchaseModel value) {
    // TODO: implement prepareEditForm
    throw UnimplementedError();
  }

  @override
  BaseModel prepareInsertModel() {
    return PurchaseInsertModel(
      fValue<String>('number', ''),
      fValue<String>('type', ''),
      'draft',
      AppState().shareState.defaultBranch()!.publicId, //fValue<String>('branchPublicId', ''),
      fValue<String>('partnerPublicId', ''),
      AppState().authState.user!.publicID,
      fValue<DateTime?>('deadline', null),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    // TODO: implement prepareUpdateModel
    throw UnimplementedError();
  }
}
