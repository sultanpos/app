import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/paymentmethod.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/util/format.dart';

class PaymentMethodState extends CrudStateWithList<PaymentMethodModel> {
  final fgMethod = FormControl<PaymentMethodType>(validators: [Validators.required]);
  final fgName = FormControl<String>(validators: [Validators.required], touched: false);
  final fgDescription = FormControl<String>();
  final fgAdditional = FormControl<String>();

  PaymentMethodState({required super.repo}) {
    form = FormGroup({
      'method': fgMethod,
      'name': fgName,
      'description': fgDescription,
      'additional': fgAdditional,
    });
  }

  @override
  prepareEditForm(PaymentMethodModel value) {
    fgName.updateValue(value.name, emitEvent: false);
    fgDescription.updateValue(value.description, emitEvent: false);
    fgAdditional.updateValue(value.additional, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return PaymentMethodInsertModel(
      0,
      fgName.value!,
      fgDescription.value ?? '',
      stockValue(fgAdditional.value ?? ''),
      fgMethod.value ?? PaymentMethodType.cash,
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    return PaymentMethodUpdateModel(
      0,
      fgName.value!,
      fgDescription.value ?? '',
      stockValue(fgAdditional.value ?? ''),
      fgMethod.value ?? PaymentMethodType.cash,
    );
  }
}
