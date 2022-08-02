import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/model/unit.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class UnitState extends BaseState {
  UnitState(super.httpAPI) : listData = ListState<Unit>(httpAPI, '/unit', Unit.fromJson);

  ListState<Unit> listData;
  bool loading = false;
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
  }

  add() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    try {
      await httpAPI.insert(UnitAddRequest(form.control('name').value));
      loading = false;
      notifyListeners();
      listData.load();
    } on ErrorResponse catch (e) {
      loading = false;
      notifyListeners();
      throw e.message;
    }
  }
}
