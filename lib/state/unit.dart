import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/crud.dart';

class UnitState extends CrudStateWithList<UnitModel> {
  final fgName = FormControl<String>(validators: [Validators.required], touched: true);
  final fgDescription = FormControl<String>();

  UnitState({required super.repo}) {
    form = FormGroup({
      'name': fgName,
      'description': fgDescription,
    });
  }

  @override
  prepareEditForm(UnitModel value) {
    fgName.updateValue(value.name, emitEvent: false);
    fgDescription.updateValue(value.description, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return UnitAddRequestModel(fgName.value!, fgDescription.value ?? '');
  }

  @override
  BaseModel prepareUpdateModel() {
    return UnitUpdateRequestModel(fgName.value!, fgDescription.value ?? '');
  }
}
