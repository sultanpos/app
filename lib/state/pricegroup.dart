import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class PriceGroupState extends BaseState {
  PriceGroupState(super.httpAPI) : listData = ListState<PriceGroup>(httpAPI, '/pricegroup', PriceGroup.fromJson);

  ListState<PriceGroup> listData;
  bool loading = false;
  PriceGroup? currentPriceGroup;
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
  }

  editForm(PriceGroup unit) {
    form.control('name').updateValue(unit.name, emitEvent: false);
    form.markAllAsTouched();
    currentPriceGroup = unit;
  }

  save() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    final value = form.control('name').value;
    try {
      if (currentPriceGroup == null) {
        await httpAPI.insert(PriceGroupAddRequest(value));
      } else {
        await httpAPI.update(PriceGroupUpdateRequest(value), currentPriceGroup!.publicId);
      }
      loading = false;
      notifyListeners();
      listData.load();
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
