import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/crud.dart';

class ProductState extends CrudState<ProductModel> {
  ProductState(super.httpAPI) : super(path: '/product', creator: ProductModel.fromJson) {
    form = FormGroup({
      'productType': FormControl<String>(validators: [Validators.required], touched: true),
      'barcode': FormControl<String>(validators: [Validators.required], touched: true),
      'name': FormControl<String>(validators: [Validators.required], touched: true),
      'description': FormControl<String>(),
      'unitPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'categoryPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'partnerPublicId': FormControl<String>(validators: [Validators.required], touched: true),
      'buyPrice': FormControl<String>(),
      'calculateStock': FormControl<bool>(),
      'sellable': FormControl<bool>(),
      'buyable': FormControl<bool>(),
      'editablePrice': FormControl<bool>(),
    });
  }

  @override
  resetForm() {
    //super.resetForm();
    //form.updateValue({'sellable': true, 'buyable': true, 'calculateStock': true, 'barcode': 'BACODE'});
    form.reset(value: {'sellable': true, 'buyable': true, 'calculateStock': true});
    form.markAllAsTouched();
    current = null;
  }

  @override
  prepareEditForm(ProductModel value) {}

  @override
  BaseModel prepareInsertModel() {
    return ProductInsertModel(
      fValue<String>('barcode', ''),
      fValue<String>('name', ''),
      fValue<String>('description', ''),
      true, //fValue<bool>('allBranch', true),
      '', //fValue<String>('mainImage', ''),
      fValue<bool>('calculateStock', true),
      fValue<String>('productType', ''),
      fValue<bool>('sellable', true),
      fValue<bool>('buyable', true),
      fValue<bool>('editablePrice', false),
      false, //fValue<bool>('useSn', false),
      fValue<String>('unitPublicId', ''),
      fValue<String>('partnerPublicId', ''),
      fValue<String>('categoryPublicId', ''),
      [],
      fMoney('buyPrice', 0),
      [],
      ProductPriceInsertModel(0, 1, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    throw UnimplementedError();
  }

  resetAddAgain() {
    form.control('name').updateValue('');
    form.control('barcode').updateValue('');
    form.control('barcode').focus();
  }
}
