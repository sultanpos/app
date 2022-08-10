import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class UnitState extends BaseState {
  UnitState(super.httpAPI) : listData = ListState<UnitModel>(httpAPI, '/unit', UnitModel.fromJson);

  ListState<UnitModel> listData;
  bool loading = false;
  UnitModel? currentUnit;
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
    'description': FormControl<String>(validators: [Validators.required], touched: true),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
  }

  editForm(UnitModel unit) {
    form.control('name').updateValue(unit.name, emitEvent: false);
    form.control('description').updateValue(unit.description, emitEvent: false);
    form.markAllAsTouched();
    currentUnit = unit;
  }

  save() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    final value = form.control('name').value;
    final desc = form.control('description').value;
    try {
      if (currentUnit == null) {
        await httpAPI.insert(UnitAddRequestModel(value, desc));
      } else {
        await httpAPI.update(UnitUpdateRequestModel(value, desc), currentUnit!.publicId);
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
      await httpAPI.delete('/unit/$publicID');
      listData.load();
    } on ErrorResponse catch (e) {
      throw e.message;
    }
  }
}
