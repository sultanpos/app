import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/crud.dart';

class PartnerState extends CrudState<PartnerModel> {
  PartnerState(super.httpAPI) : super(path: '/partner', creator: PartnerModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'isCustomer': FormControl<bool>(),
      'isSupplier': FormControl<bool>(),
      'address': FormControl<String>(),
      'phone': FormControl<String>(validators: [Validators.number]),
      'email': FormControl<String>(validators: [Validators.email]),
      'npwp': FormControl<String>(),
      'priceGroupPublicId': FormControl<String>(),
    });
  }

  @override
  prepareEditForm(PartnerModel value) {
    form.control('name').updateValue(value.name, emitEvent: false);
    form.control('isCustomer').updateValue(value.isCustomer, emitEvent: false);
    form.control('isSupplier').updateValue(value.isSupplier, emitEvent: false);
    form.control('address').updateValue(value.address, emitEvent: false);
    form.control('phone').updateValue(value.phone, emitEvent: false);
    form.control('email').updateValue(value.email, emitEvent: false);
    form.control('npwp').updateValue(value.npwp, emitEvent: false);
    form.control('priceGroupPublicId').updateValue(value.priceGroupPublicId, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    final values = form.value;
    return PartnerInsertModel(values['isSupplier'] as bool, values['isCustomer'] as bool, values['name'] as String, values['address'] as String,
        values['phone'] as String, values['npwp'] as String, values['email'] as String, values['priceGroupPublicId'] as String);
  }

  @override
  BaseModel prepareUpdateModel() {
    final values = form.value;
    return PartnerUpdateModel(values['isSupplier'] as bool, values['isCustomer'] as bool, values['name'] as String, values['address'] as String,
        values['phone'] as String, values['npwp'] as String, values['email'] as String, values['priceGroupPublicId'] as String);
  }
}
