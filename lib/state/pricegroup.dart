import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/crud.dart';

class PriceGroupState extends CrudState<PriceGroupModel> {
  final fgName = FormControl<String>(validators: [Validators.required], touched: true);
  final fgDescription = FormControl<String>();
  final fgPublicDescription = FormControl<String>();

  PriceGroupState(super.httpAPI) : super(path: '/pricegroup', creator: PriceGroupModel.fromJson) {
    form = FormGroup({
      'name': fgName,
      'description': fgDescription,
      'publicDescription': fgPublicDescription,
    });
  }

  @override
  prepareEditForm(PriceGroupModel value) {
    fgName.updateValue(value.name, emitEvent: false);
    fgDescription.updateValue(value.description, emitEvent: false);
    fgPublicDescription.updateValue(value.publicDescription, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return PriceGroupAddRequestModel(fgName.value!, fgDescription.value ?? '', fgPublicDescription.value ?? '');
  }

  @override
  BaseModel prepareUpdateModel() {
    return PriceGroupUpdateRequestModel(fgName.value!, fgDescription.value ?? '', fgPublicDescription.value ?? '');
  }
}
