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
  String? _id;
  int priceCounter = 1;
  final List<DiscountMargin> discountMargins = [
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
    DiscountMargin(0, 0, 0),
  ];
  final fgProductType = FormControl<String>(validators: [Validators.required], touched: false);
  final fgBarcode = FormControl<String>(validators: [Validators.required], touched: false);
  final fgName = FormControl<String>(validators: [Validators.required], touched: false);
  final fgDescription = FormControl<String>();
  final fgUnitId = FormControl<int>(validators: [Validators.required], touched: false);
  final fgCategoryId = FormControl<int>(validators: [Validators.required], touched: false);
  final fgPartnerId = FormControl<int>(validators: [Validators.required], touched: false);
  final fgBuyPrice = FormControl<String>();
  final fgCalculateStock = FormControl<bool>(value: true);
  final fgSellable = FormControl<bool>(value: true);
  final fgBuyable = FormControl<bool>(value: true);
  final fgEditablePrice = FormControl<bool>(value: false);
  final fgStock = FormControl<String>();
  final List<CountSellDisc> csd = [
    CountSellDisc(FormControl<String>(disabled: true, value: "1"), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
    CountSellDisc(FormControl<String>(), FormControl<String>(), FormControl<String>()),
  ];

  ProductState({required super.repo}) {
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

  String getId() {
    return _id ?? 'add';
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
    _id = '${value.id}';
    final valueMap = {
      'name': value.name,
      'barcode': value.barcode,
      'productType': value.productType.value,
      'unitId': value.unit?.id,
      'categoryId': value.category?.id,
      'partnerId': value.partner?.id,
      'sellable': value.sellable,
      'buyable': value.buyable,
      'calculateStock': value.calculateStock,
      'editablePrice': value.editablePrice,
    };
    fgStock.markAsDisabled(emitEvent: false);
    fgBuyPrice.markAsDisabled(emitEvent: false);
    final defPrice = value.prices?.firstWhere(
      (element) => element.priceGroup.isDefault,
    );
    priceCounter = 0;
    final priceMap = defPrice?.toJson();
    if (priceMap != null) {
      for (int i = 0; i < 5; i++) {
        if (priceMap['count$i'] > 0) {
          priceCounter++;
          valueMap['count$i'] = formatStock(priceMap['count$i']);
          valueMap['sell$i'] = formatMoney(priceMap['price$i']);
          valueMap['disc$i'] = priceMap['discount_formula$i'];
        }
      }
    }
    final buyPrice = value.buyPrices?.firstWhere((element) => element.branch.isDefault);
    if (buyPrice != null) {
      valueMap['buyPrice'] = '${buyPrice.buyPrice}';
    }
    form.updateValue(valueMap, updateParent: false, emitEvent: false);
    calculateDisc();
  }

  @override
  BaseModel prepareInsertModel() {
    final branch = AppState().global.currentBranch!;
    final priceMap = <String, dynamic>{};
    for (int i = 0; i < 5; i++) {
      priceMap['count$i'] = i < priceCounter ? stockValue(csd[i].count.value ?? '0') : 0;
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
      [ProductStockInsertModel(branch.id, stockValue(fgStock.value ?? '0'))],
      ProductPriceInsertModel.fromJson(priceMap),
    );
  }

  @override
  BaseModel prepareUpdateModel() {
    final priceMap = <String, dynamic>{};
    for (int i = 0; i < 5; i++) {
      priceMap['count$i'] = i < priceCounter ? stockValue(csd[i].count.value ?? '0') : 0;
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
      fgCalculateStock.value ?? false,
      fgProductType.value ?? '',
      fgUnitId.value ?? 0,
      fgPartnerId.value ?? 0,
      fgCategoryId.value ?? 0,
      fgSellable.value ?? false,
      fgBuyable.value ?? false,
      fgEditablePrice.value ?? false,
      false, //fValue<bool>('useSn', false),
      ProductPriceInsertModel.fromJson(priceMap),
    );
  }

  resetAddAgain() {
    fgName.updateValue('');
    fgBarcode.updateValue('');
    fgStock.updateValue('');
    fgBuyPrice.updateValue('');
    for (int i = 0; i < 5; i++) {
      if (i > 0) csd[i].count.updateValue('');
      csd[i].sell.updateValue('');
      csd[i].discount.updateValue('');
    }
    fgName.markAsUntouched();
    fgBarcode.markAsUntouched();
    fgBarcode.focus();
  }

  addPrice() {
    priceCounter++;
    notifyListeners();
  }

  removePrice(int index) {
    priceCounter--;
    for (int i = 0; i < 5; i++) {
      if (i >= index) {
        final j = i + 1;
        csd[i].count.updateValue(i < priceCounter ? csd[j].count.value : '');
        csd[i].sell.updateValue(i < priceCounter ? csd[j].sell.value : '');
        csd[i].discount.updateValue(i < priceCounter ? csd[j].discount.value : '');
      }
    }
    notifyListeners();
  }

  @override
  afterSaveSuccess() {
    AppState().productRootState.productList.load(refresh: true);
  }
}
