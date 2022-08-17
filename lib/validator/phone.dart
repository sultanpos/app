import 'package:reactive_forms/reactive_forms.dart';

class PhoneValidator extends Validator<dynamic> {
  static final RegExp phoneRegex = RegExp(r'\+?([ -]?\d+)+|\(\d+\)([ -]\d+)');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return (control.value == null || control.value.toString() == "" || phoneRegex.hasMatch(control.value.toString()))
        ? null
        : <String, dynamic>{'nomor telepon': true};
  }
}
