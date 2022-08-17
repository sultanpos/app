import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/crud.dart';

class ProductState extends CrudState<ProductModel> {
  ProductState(super.httpAPI) : super(path: '/product', creator: ProductModel.fromJson) {
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'description': FormControl<String>(),
    });
  }

  @override
  prepareEditForm(ProductModel value) {}

  @override
  BaseModel prepareInsertModel() {
    throw UnimplementedError();
  }

  @override
  BaseModel prepareUpdateModel() {
    throw UnimplementedError();
  }
}
