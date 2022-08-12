import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/error.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class CategoryState extends BaseState {
  CategoryState(super.httpAPI) : listData = ListState<CategoryModel>(httpAPI, '/category', CategoryModel.fromJson);

  ListState<CategoryModel> listData;
  bool loading = false;
  CategoryModel? currentCategory;
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required], touched: true),
    'code': FormControl<String>(),
    'description': FormControl<String>(),
    'parent_public_id': FormControl<String>(),
  });

  resetForm() {
    form.reset();
    form.markAllAsTouched();
    currentCategory = null;
  }

  editForm(CategoryModel category) {
    form.control('name').updateValue(category.name, emitEvent: false);
    form.control('description').updateValue(category.description, emitEvent: false);
    form.control('code').updateValue(category.code, emitEvent: false);
    form.control('parent_public_id').updateValue(category.parentPublicId, emitEvent: false);
    form.markAllAsTouched();
    currentCategory = category;
  }

  save() async {
    if (!form.valid) return;
    loading = true;
    notifyListeners();
    final values = form.value;
    try {
      if (currentCategory == null) {
        await httpAPI.insert(CategoryInsertModel(
            values['name'] as String, values['code'] as String, values['description'] as String, values['parent_public_id'] as String));
      } else {
        await httpAPI.update(
            CategoryUpdateModel(
                values['name'] as String, values['code'] as String, values['description'] as String, values['parent_public_id'] as String),
            currentCategory!.publicId);
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
      await httpAPI.delete('/category/$publicID');
      listData.load(refresh: true);
    } on ErrorResponse catch (e) {
      throw e.message;
    }
  }
}
