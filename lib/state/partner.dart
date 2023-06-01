import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/validator/phone.dart';

class PartnerState extends CrudState<PartnerModel> {
  final fgName = FormControl<String>(validators: [Validators.required], touched: true);
  final fgIsCustomer = FormControl<bool>();
  final fgIsSupplier = FormControl<bool>();
  final fgAddress = FormControl<String>();
  final fgPhone = FormControl<String>(validators: [PhoneValidator().validate]);
  final fgEmail = FormControl<String>(validators: [Validators.email]);
  final fgNpwp = FormControl<String>();
  final fgPriceGroup = FormControl<int>();
  PartnerState(super.httpAPI) : super(path: '/partner', creator: PartnerModel.fromJson) {
    form = FormGroup({
      'name': fgName,
      'isCustomer': fgIsCustomer,
      'isSupplier': fgIsSupplier,
      'address': fgAddress,
      'phone': fgPhone,
      'email': fgEmail,
      'npwp': fgNpwp,
      'priceGroupId': fgPriceGroup,
    });
  }

  @override
  prepareEditForm(PartnerModel value) {
    fgName.updateValue(value.name, emitEvent: false);
    fgIsCustomer.updateValue(value.isCustomer, emitEvent: false);
    fgIsSupplier.updateValue(value.isSupplier, emitEvent: false);
    fgAddress.updateValue(value.address, emitEvent: false);
    fgPhone.updateValue(value.phone, emitEvent: false);
    fgEmail.updateValue(value.email, emitEvent: false);
    fgNpwp.updateValue(value.npwp, emitEvent: false);
    fgPriceGroup.updateValue(value.priceGroup?.id, emitEvent: false);
  }

  @override
  resetForm() {
    super.resetForm();
    fgPriceGroup.updateValue(AppState().shareState.defaultPriceGroup?.id ?? 0, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return PartnerInsertModel(
      fgIsSupplier.value ?? false,
      fgIsCustomer.value ?? false,
      fgName.value ?? '',
      fgAddress.value ?? '',
      fgPhone.value ?? '',
      fgNpwp.value ?? '',
      fgEmail.value ?? '',
      fgPriceGroup.value ?? 0,
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    return PartnerUpdateModel(
      fgIsSupplier.value ?? false,
      fgIsCustomer.value ?? false,
      fgName.value ?? '',
      fgAddress.value ?? '',
      fgPhone.value ?? '',
      fgNpwp.value ?? '',
      fgEmail.value ?? '',
      fgPriceGroup.value ?? 0,
    );
  }
}
