import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/state/crud.dart';

class PurchaseItemState extends CrudState<PurchaseItemModel> {
  PurchaseModel purchase;
  PurchaseItemState(HttpAPI httpAPI, {required this.purchase})
      : super(httpAPI, path: "/purchase/${purchase.id}", creator: PurchaseItemModel.fromJson) {
    form = FormGroup({});
  }

  @override
  prepareEditForm(PurchaseItemModel value) {
    throw UnimplementedError();
  }

  @override
  BaseModel prepareInsertModel() {
    // TODO: implement prepareInsertModel
    throw UnimplementedError();
  }

  @override
  BaseModel prepareUpdateModel() {
    // TODO: implement prepareUpdateModel
    throw UnimplementedError();
  }
}
