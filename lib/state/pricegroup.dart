import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/crud.dart';

class PriceGroupState extends CrudState<PriceGroupModel> {
  PriceGroupState(super.httpAPI) : super(path: '/pricegroup', creator: PriceGroupModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'description': FormControl<String>(),
      'publicDescription': FormControl<String>(),
    });
  }

  @override
  prepareEditForm(PriceGroupModel value) {
    form.control('name').updateValue(value.name, emitEvent: false);
    form.control('description').updateValue(value.description, emitEvent: false);
    form.control('publicDescription').updateValue(value.publicDescription, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    final value = form.control('name').value;
    final desc = form.control('description').value;
    final pubDesc = form.control('publicDescription').value;
    return PriceGroupAddRequestModel(value, desc, pubDesc);
  }

  @override
  BaseModel prepareUpdateModel() {
    final value = form.control('name').value;
    final desc = form.control('description').value;
    final pubDesc = form.control('publicDescription').value;
    return PriceGroupUpdateRequestModel(value, desc, pubDesc);
  }
}
