import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/validator/phone.dart';

class PartnerState extends CrudState<PartnerModel> {
  PartnerState(super.httpAPI) : super(path: '/partner', creator: PartnerModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'isCustomer': FormControl<bool>(),
      'isSupplier': FormControl<bool>(),
      'address': FormControl<String>(),
      'phone': FormControl<String>(validators: [PhoneValidator().validate]),
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
    form.control('priceGroupPublicId').updateValue(value.priceGroup.publicId, emitEvent: false);
  }

  @override
  resetForm() {
    super.resetForm();
    form.control('priceGroupPublicId').updateValue(AppState().shareState.defaultPriceGroup?.publicId ?? "", emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return PartnerInsertModel(
      fValue<bool>('isSupplier', false),
      fValue<bool>('isCustomer', false),
      fValue<String>('name', ''),
      fValue<String>('address', ''),
      fValue<String>('phone', ''),
      fValue<String>('npwp', ''),
      fValue<String>('email', ''),
      fValue<String>('priceGroupPublicId', ''),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    return PartnerUpdateModel(
      fValue<bool>('isSupplier', false),
      fValue<bool>('isCustomer', false),
      fValue<String>('name', ''),
      fValue<String>('address', ''),
      fValue<String>('phone', ''),
      fValue<String>('npwp', ''),
      fValue<String>('email', ''),
      fValue<String>('priceGroupPublicId', ''),
    );
  }
}
