import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/crud.dart';

class CategoryState extends CrudState<CategoryModel> {
  CategoryState(super.httpAPI) : super(path: '/category', creator: CategoryModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'code': FormControl<String>(),
      'description': FormControl<String>(),
      'parent_public_id': FormControl<String>(),
    });
  }

  @override
  prepareEditForm(CategoryModel value) {
    form.control('name').updateValue(value.name, emitEvent: false);
    form.control('description').updateValue(value.description, emitEvent: false);
    form.control('code').updateValue(value.code, emitEvent: false);
    form.control('parent_public_id').updateValue(value.parentPublicId, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    final values = form.value;
    return CategoryInsertModel(
        values['name'] as String, values['code'] as String, values['description'] as String, values['parent_public_id'] as String);
  }

  @override
  BaseModel prepareUpdateModel() {
    final values = form.value;
    return CategoryUpdateModel(
        values['name'] as String, values['code'] as String, values['description'] as String, values['parent_public_id'] as String);
  }
}
