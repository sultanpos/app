import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/crud.dart';

class ProductState extends CrudState<ProductModel> {
  ProductState(super.httpAPI) : super(path: '/product', creator: ProductModel.fromJson) {
    form = FormGroup({
      'product_type': FormControl<String>(validators: [Validators.required], touched: true),
      'barcode': FormControl<String>(validators: [Validators.required], touched: true),
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'description': FormControl<String>(),
      'unit_public_id': FormControl<String>(validators: [Validators.required], touched: true),
      'category_public_id': FormControl<String>(validators: [Validators.required], touched: true),
      'buy_price': FormControl<int>(validators: [Validators.min<int>(0)], touched: true),
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
