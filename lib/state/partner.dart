import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class PartnerState extends BaseState {
  PartnerState(super.httpAPI) : listData = ListState<PartnerModel>(httpAPI, '/partner', PartnerModel.fromJson);

  ListState<PartnerModel> listData;
  bool loading = false;
  PartnerModel? currentUnit;

  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
    'isCustomer': FormControl<bool>(),
    'isSupplier': FormControl<bool>(),
    'address': FormControl<String>(),
    'phone': FormControl<String>(validators: [Validators.number]),
    'email': FormControl<String>(validators: [Validators.email]),
    'npwp': FormControl<String>(),
    'priceGroupPublicId': FormControl<String>(validators: [Validators.email]),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
  }

  editForm(PartnerModel unit) {
    form.control('name').updateValue(unit.name, emitEvent: false);
    form.markAllAsTouched();
    currentUnit = unit;
  }

  save() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    final value = form.control('name').value;
    try {
      if (currentUnit == null) {
        //await httpAPI.insert(PartnerInsertModel());
      } else {
        //await httpAPI.update(UnitUpdateRequestModel(value, desc), currentUnit!.publicId);
      }
      loading = false;
      notifyListeners();
      listData.load(refresh: true);
    } on ErrorResponse catch (e) {
      loading = false;
      notifyListeners();
      throw e.message;
    }
  }

  remove(String publicID) async {
    try {
      await httpAPI.delete('/partner/$publicID');
      listData.load();
    } on ErrorResponse catch (e) {
      throw e.message;
    }
  }
}
