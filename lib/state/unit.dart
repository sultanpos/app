import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/crud.dart';

class UnitState extends CrudState<UnitModel> {
  UnitState(super.httpAPI) : super(path: '/unit', creator: UnitModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'description': FormControl<String>(),
    });
  }

  @override
  prepareEditForm(UnitModel value) {
    form.control('name').updateValue(value.name, emitEvent: false);
    form.control('description').updateValue(value.description, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    final value = form.control('name').value;
    final desc = form.control('description').value;
    return UnitAddRequestModel(value, desc);
  }

  @override
  BaseModel prepareUpdateModel() {
    final value = form.control('name').value;
    final desc = form.control('description').value;
    return UnitUpdateRequestModel(value, desc);
  }
}
