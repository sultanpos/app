import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/state/crud.dart';

class CategoryState extends CrudStateWithList<CategoryModel> {
  final fgName = FormControl<String>(validators: [Validators.required], touched: false);
  final fgCode = FormControl<String>(validators: [Validators.required], touched: false);
  final fgDescription = FormControl<String>();
  final fgParentId = FormControl<int>();

  CategoryState(super.httpAPI) : super(path: '/category', creator: CategoryModel.fromJson) {
    form = FormGroup({
      'name': fgName,
      'code': fgCode,
      'description': fgDescription,
      'parent_id': fgParentId,
    });
  }

  @override
  prepareEditForm(CategoryModel value) {
    fgName.updateValue(value.name, emitEvent: false);
    fgDescription.updateValue(value.description, emitEvent: false);
    fgCode.updateValue(value.code, emitEvent: false);
    fgParentId.updateValue(value.parentId, emitEvent: false);
  }

  @override
  BaseModel prepareInsertModel() {
    return CategoryInsertModel(fgName.value!, fgCode.value ?? '', fgDescription.value ?? '', fgParentId.value ?? 0);
  }

  @override
  BaseModel prepareUpdateModel() {
    return CategoryUpdateModel(fgName.value!, fgCode.value ?? '', fgDescription.value ?? '', fgParentId.value ?? 0);
  }
}
