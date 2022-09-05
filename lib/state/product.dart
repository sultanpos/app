import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/ui/util/calculate.dart';

class DiscountMargin {
  int discount;
  int finalPrice;
  double margin;
  DiscountMargin(this.discount, this.finalPrice, this.margin);
}

class ProductState extends CrudState<ProductModel> {
  int priceCounter = 1;
  List<DiscountMargin> discountMargins = [
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
  ];

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
      'stock': FormControl<String>(),
      'count0': FormControl<int>(disabled: true, value: 1),
      'sell0': FormControl<String>(),
      'disc0': FormControl<String>(),
      'count1': FormControl<int>(),
      'sell1': FormControl<String>(),
      'disc1': FormControl<String>(),
      'count2': FormControl<int>(),
      'sell2': FormControl<String>(),
      'disc2': FormControl<String>(),
      'count3': FormControl<int>(),
      'sell3': FormControl<String>(),
      'disc3': FormControl<String>(),
      'count4': FormControl<int>(),
      'sell4': FormControl<String>(),
      'disc4': FormControl<String>(),
    });
    form.control('buyPrice').valueChanges.listen((event) {
      calculateDisc();
    });
    for (int i = 0; i < 5; i++) {
      form.control('sell$i').valueChanges.listen((event) {
        calculateDisc();
      });
      form.control('disc$i').valueChanges.listen((event) {
        calculateDisc();
      });
    }
  }

  calculateDisc() {
    final buy = fMoney('buyPrice', 0);
    for (int i = 0; i < 5; i++) {
      final sell = fMoney('sell$i', 0);
      final discFormula = fValue<String>('disc$i', '');
      final disc = calculateDiscount(sell, discFormula);
      discountMargins[i].finalPrice = sell - disc;
      discountMargins[i].discount = calculateDiscount(sell, discFormula);
      discountMargins[i].margin = calculateMargin(buy, sell - disc);
    }
    notifyListeners();
  }

  @override
  resetForm() {
    form.reset(value: {'sellable': true, 'buyable': true, 'calculateStock': true, 'count1': 1});
    form.markAllAsTouched();
    current = null;
  }

  @override
  prepareEditForm(ProductModel value) {
    form.updateValue({
      'name': value.name,
      'barcode': value.barcode,
      'productType': value.productType,
      'unitPublicId': value.unit.publicId,
      'categoryPublicId': value.category.publicId,
      'partnerPublicId': value.partner.publicId,
      'sellable': value.sellable,
      'buyable': value.buyable,
      'calculateStock': value.calculateStock,
      'editablePrice': value.editablePrice,
    });
    priceCounter = 2;
  }

  @override
  BaseModel prepareInsertModel() {
    final defaultBranch = AppState().shareState.defaultBranch();
    final priceMap = <String, dynamic>{};
    for (int i = 0; i < 5; i++) {
      priceMap['count$i'] = i < priceCounter ? fMoney('count$i', 0) : 0;
      priceMap['price$i'] = i < priceCounter ? fMoney('sell$i', 0) : 0;
      priceMap['discount_formula$i'] = i < priceCounter ? fValue<String>('disc$i', '') : '';
      priceMap['discount$i'] = i < priceCounter ? discountMargins[i].discount : 0;
    }
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
      [ProductStockInsertModel(defaultBranch!.publicId, fMoney('stock', 0))],
      ProductPriceInsertModel.fromJson(priceMap),
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

  addPrice() {
    priceCounter++;
    notifyListeners();
  }

  removePrice() {
    priceCounter--;
    notifyListeners();
  }
}
