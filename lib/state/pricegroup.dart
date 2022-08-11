import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class PriceGroupState extends BaseState {
  PriceGroupState(super.httpAPI) : listData = ListState<PriceGroupModel>(httpAPI, '/pricegroup', PriceGroupModel.fromJson);

  ListState<PriceGroupModel> listData;
  bool loading = false;
  PriceGroupModel? currentPriceGroup;
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
    'description': FormControl<String>(),
    'publicDescription': FormControl<String>(),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
  }

  editForm(PriceGroupModel unit) {
    form.control('name').updateValue(unit.name, emitEvent: false);
    form.control('description').updateValue(unit.description, emitEvent: false);
    form.control('publicDescription').updateValue(unit.publicDescription, emitEvent: false);
    form.markAllAsTouched();
    currentPriceGroup = unit;
  }

  save() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    final value = form.control('name').value;
    final desc = form.control('description').value;
    final pubDesc = form.control('publicDescription').value;
    try {
      if (currentPriceGroup == null) {
        await httpAPI.insert(PriceGroupAddRequestModel(value, desc, pubDesc));
      } else {
        await httpAPI.update(PriceGroupUpdateRequestModel(value, desc, pubDesc), currentPriceGroup!.publicId);
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
      await httpAPI.delete('/pricegroup/$publicID');
      listData.load();
    } on ErrorResponse catch (e) {
      throw e.message;
    }
  }
}
