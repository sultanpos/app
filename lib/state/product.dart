import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/util/calculate.dart';
import 'package:sultanpos/util/format.dart';

class DiscountMargin {
  int discount;
  int finalPrice;
  double margin;
  DiscountMargin(this.discount, this.finalPrice, this.margin);
}

class CountSellDisc {
  FormControl<String> count;
  FormControl<String> sell;
  FormControl<String> discount;
  CountSellDisc(this.count, this.sell, this.discount);
}

class ProductState extends CrudState<ProductModel> {
  int priceCounter = 1;
  final List<DiscountMargin> discountMargins = [
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
  ];
  final fgProductType = FormControl<String>(validators: [Validators.required], touched: true);
  final fgBarcode = FormControl<String>(validators: [Validators.required], touched: true);
  final fgName = FormControl<String>(validators: [Validators.required], touched: true);
  final fgDescription = FormControl<String>();
  final fgUnitId = FormControl<int>(validators: [Validators.required], touched: true);
  final fgCategoryId = FormControl<int>(validators: [Validators.required], touched: true);
  final fgPartnerId = FormControl<int>(validators: [Validators.required], touched: true);
  final fgBuyPrice = FormControl<String>();
  final fgCalculateStock = FormControl<bool>();
  final fgSellable = FormControl<bool>();
  final fgBuyable = FormControl<bool>();
  final fgEditablePrice = FormControl<bool>();
  final fgStock = FormControl<String>();
  final List<CountSellDisc> csd = [
    CountSellDisc(FormControl<String>(disabled: true, value: "1"), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
  ];

  ProductState(super.httpAPI) : super(path: '/product', creator: ProductModel.fromJson) {
    form = FormGroup({
      'productType': fgProductType,
      'barcode': fgBarcode,
      'name': fgName,
      'description': fgDescription,
      'unitId': fgUnitId,
      'categoryId': fgCategoryId,
      'partnerId': fgPartnerId,
      'buyPrice': fgBuyPrice,
      'calculateStock': fgCalculateStock,
      'sellable': fgSellable,
      'buyable': fgBuyable,
      'editablePrice': fgEditablePrice,
      'stock': fgStock,
      'count0': csd[0].count,
      'sell0': csd[0].sell,
      'disc0': csd[0].discount,
      'count1': csd[1].count,
      'sell1': csd[1].sell,
      'disc1': csd[1].discount,
      'count2': csd[2].count,
      'sell2': csd[2].sell,
      'disc2': csd[2].discount,
      'count3': csd[3].count,
      'sell3': csd[3].sell,
      'disc3': csd[3].discount,
      'count4': csd[4].count,
      'sell4': csd[4].sell,
      'disc4': csd[4].discount,
    });
    fgBuyPrice.valueChanges.listen((event) {
      calculateDisc();
    });
    for (int i = 0; i < 5; i++) {
      csd[i].sell.valueChanges.listen((event) {
        calculateDisc();
      });
      csd[i].discount.valueChanges.listen((event) {
        calculateDisc();
      });
    }
  }

  calculateDisc() {
    final buy = moneyValue(fgBuyPrice.value ?? '0');
    for (int i = 0; i < 5; i++) {
      final sell = moneyValue(csd[i].sell.value ?? '0');
      final discFormula = csd[i].discount.value ?? '';
      final disc = calculateDiscount(sell, discFormula);
      discountMargins[i].finalPrice = sell - disc;
      discountMargins[i].discount = calculateDiscount(sell, discFormula);
      discountMargins[i].margin = calculateMargin(buy, sell - disc);
    }
    notifyListeners();
  }

  @override
  resetForm() {
    fgStock.markAsEnabled(emitEvent: false);
    fgBuyPrice.markAsEnabled(emitEvent: false);
    form.reset(value: {'sellable': true, 'buyable': true, 'calculateStock': true, 'count0': "1"});
    form.markAllAsTouched();
    current = null;
  }

  @override
  prepareEditForm(ProductModel value) {
    final valueMap = {
      'name': value.name,
      'barcode': value.barcode,
      'productType': value.productType,
      'unitId': value.unit.id,
      'categoryId': value.category.id,
      'partnerId': value.partner.id,
      'sellable': value.sellable,
      'buyable': value.buyable,
      'calculateStock': value.calculateStock,
      'editablePrice': value.editablePrice,
    };
    fgStock.markAsDisabled(emitEvent: false);
    fgBuyPrice.markAsDisabled(emitEvent: false);
    final defPrice = value.prices.firstWhere(
      (element) => element.priceGroup.isDefault,
    );
    priceCounter = 0;
    final priceMap = defPrice.toJson();
    for (int i = 0; i < 5; i++) {
      if (priceMap['count$i'] > 0) {
        priceCounter++;
        valueMap['count$i'] = '${priceMap['count$i']}';
        valueMap['sell$i'] = '${priceMap['price$i']}';
        valueMap['disc$i'] = priceMap['discount_formula$i'];
      }
    }
    final buyPrice = value.buyPrices.firstWhere((element) => element.branch.isDefault);
    valueMap['buyPrice'] = '${buyPrice.buyPrice}';
    form.updateValue(valueMap, updateParent: false, emitEvent: false);
    calculateDisc();
  }

  @override
  BaseModel prepareInsertModel() {
    final defaultBranch = AppState().shareState.defaultBranch();
    final priceMap = <String, dynamic>{};
    for (int i = 0; i < 5; i++) {
      priceMap['count$i'] = i < priceCounter ? moneyValue(csd[i].count.value ?? '0') : 0;
      priceMap['price$i'] = i < priceCounter ? moneyValue(csd[i].sell.value ?? '0') : 0;
      priceMap['discount_formula$i'] = i < priceCounter ? csd[i].discount.value ?? '' : '';
      priceMap['discount$i'] = i < priceCounter ? discountMargins[i].discount : 0;
    }
    return ProductInsertModel(
      fgBarcode.value ?? '',
      fgName.value ?? '',
      fgDescription.value ?? '',
      true, //fValue<bool>('allBranch', true),
      '', //fValue<String>('mainImage', ''),
      fgCalculateStock.value ?? true,
      fgProductType.value ?? '',
      fgSellable.value ?? true,
      fgBuyable.value ?? true,
      fgEditablePrice.value ?? false,
      false, //fValue<bool>('useSn', false),
      fgUnitId.value ?? 0,
      fgPartnerId.value ?? 0,
      fgCategoryId.value ?? 0,
      [],
      moneyValue(fgBuyPrice.value ?? '0'),
      [ProductStockInsertModel(defaultBranch!.id, stockValue(fgStock.value ?? '0'))],
      ProductPriceInsertModel.fromJson(priceMap),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    final priceMap = <String, dynamic>{};
    for (int i = 0; i < 5; i++) {
      priceMap['count$i'] = i < priceCounter ? moneyValue(csd[i].count.value ?? '0') : 0;
      priceMap['price$i'] = i < priceCounter ? moneyValue(csd[i].sell.value ?? '0') : 0;
      priceMap['discount_formula$i'] = i < priceCounter ? csd[i].discount.value ?? '' : '';
      priceMap['discount$i'] = i < priceCounter ? discountMargins[i].discount : 0;
    }
    return ProductUpdateModel(
      fgBarcode.value ?? '',
      fgName.value ?? '',
      fgDescription.value ?? '',
      true, //fValue<bool>('allBranch', true),
      '', //fValue<String>('mainImage', ''),
      fgCalculateStock.value ?? true,
      fgProductType.value ?? '',
      fgUnitId.value ?? 0,
      fgPartnerId.value ?? 0,
      fgCategoryId.value ?? 0,
      fgSellable.value ?? true,
      fgBuyable.value ?? true,
      fgEditablePrice.value ?? false,
      false, //fValue<bool>('useSn', false),
      ProductPriceInsertModel.fromJson(priceMap),
    );
  }

  resetAddAgain() {
    fgName.updateValue('');
    fgBarcode.updateValue('');
    fgBarcode.focus();
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
