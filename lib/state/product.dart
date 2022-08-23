import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/ui/util/calculate.dart';

class DiscountMargin {
  int discount;
  int margin;
  String marginStr;
  DiscountMargin(this.discount, this.margin, this.marginStr);
}

class ProductState extends CrudState<ProductModel> {
  int priceCounter = 1;
  List<DiscountMargin> discountMargins = [
    DiscountMargin(0, 0, "0"),
    DiscountMargin(0, 0, "0"),
    DiscountMargin(0, 0, "0"),
    DiscountMargin(0, 0, "0"),
    DiscountMargin(0, 0, "0"),
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
      'count1': FormControl<int>(disabled: true, value: 1),
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
      'count5': FormControl<int>(),
      'sell5': FormControl<String>(),
      'disc5': FormControl<String>(),
    });
    form.control('buyPrice').valueChanges.listen((event) {
      calculateDisc();
    });
    for (int i = 0; i < 5; i++) {
      form.control('sell${i + 1}').valueChanges.listen((event) {
        calculateDisc();
      });
      form.control('disc${i + 1}').valueChanges.listen((event) {
        calculateDisc();
      });
    }
  }

  calculateDisc() {
    final buy = fMoney('buyPrice', 0);
    for (int i = 0; i < 5; i++) {
      final sell = fMoney('sell${i + 1}', 0);
      final discFormula = fValue<String>('disc${i + 1}', '');
      discountMargins[i] =
          DiscountMargin(calculateDiscount(sell, discFormula), calculateMargin(buy, sell).toInt(), calculateMargin(buy, sell).toStringAsFixed(0));
      /*discountMargins[i].discount = calculateDiscount(sell, discFormula);
      discountMargins[i].margin = calculateMargin(buy, sell).toInt();
      discountMargins[i].marginStr = calculateMargin(buy, sell).toStringAsFixed(0);*/
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
  prepareEditForm(ProductModel value) {}

  @override
  BaseModel prepareInsertModel() {
    final stock = fMoney('stock', 0);
    final defaultBranch = AppState().shareState.defaultBranch();
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
      [ProductStockInsertModel(defaultBranch!.publicId, stock)],
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

  addPrice() {
    priceCounter++;
    notifyListeners();
  }

  removePrice() {
    priceCounter--;
    notifyListeners();
  }
}
