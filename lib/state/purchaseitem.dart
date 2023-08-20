import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/state/crud.dart';
import 'package:sultanpos/util/calculate.dart';
import 'package:sultanpos/util/format.dart';

class PurchaseItemState extends CrudStateWithList<PurchaseItemModel> {
  final ProductRepository productRepo;
  final PurchaseRepository purchaseRepo;
  PurchaseModel purchase;
  ProductModel? product;
  String? error;
  bool barcodeInFocus = false;
  bool productLoading = false;
  bool saving = false;
  int total = 0;
  int discount = 0;

  final fgBarcode = FormControl<String>();
  final fgPrice = FormControl<String>();
  final fgCount = FormControl<String>();
  final fgDiscountFormula = FormControl<String>();

  PurchaseItemState(
      {required this.purchase, required super.repo, required this.productRepo, required this.purchaseRepo}) {
    form = FormGroup({
      'barcode': fgBarcode,
      'price': fgPrice,
      'count': fgCount,
      'discountFormula': fgDiscountFormula,
    });
    fgBarcode.focusChanges.listen((event) {
      if (barcodeInFocus && !event) {
        loadBarcode();
      }
      barcodeInFocus = event;
    });
    fgPrice.valueChanges.listen((event) {
      calculate();
    });
    fgCount.valueChanges.listen((event) {
      calculate();
    });
    fgDiscountFormula.valueChanges.listen((event) {
      calculate();
    });
  }

  loadBarcode() async {
    final barcodeValue = fgBarcode.value ?? '';
    if (barcodeValue.isEmpty) {
      return;
    }
    productLoading = true;
    error = null;
    product = null;
    notifyListeners();
    try {
      final products = await productRepo.query(BaseFilterModel(limit: 10, offset: 0, where: {
        'barcode': fgBarcode.value ?? '',
        'buyable': true,
      }));
      if (products.data.isEmpty) {
        throw 'product not found';
      }
      product = products.data.first;
      productLoading = false;
      notifyListeners();
    } catch (e) {
      productLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  @override
  save() {
    if (product == null) {
      throw 'product is null';
    }
    return super.save();
  }

  @override
  prepareEditForm(PurchaseItemModel value) {
    fgBarcode.updateValue(value.product?.barcode);
    fgCount.updateValue(formatStock(value.amount));
    fgPrice.updateValue(formatMoney(value.price));
    loadBarcode();
  }

  @override
  BaseModel prepareInsertModel() {
    return PurchaseItemInsertModel(product!.id, 0, stockValue(fgCount.value!), moneyValue(fgPrice.value!), '', '');
  }

  @override
  BaseModel prepareUpdateModel() {
    return PurchaseItemUpdateModel(product!.id, stockValue(fgCount.value!), moneyValue(fgPrice.value!), '', '');
  }

  @override
  resetForm() {
    product = null;
    error = null;
    super.resetForm();
    fgBarcode.focus();
  }

  refreshPurchase() async {
    try {
      final p = await purchaseRepo.get(purchase.id);
      if (p == null) {
        throw 'purchase not found';
      }
      purchase = p;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  calculate() {
    final amount = stockValue(fgCount.value ?? '0');
    final price = moneyValue(fgPrice.value ?? '0');
    final disFormula = fgDiscountFormula.value ?? '';
    discount = calculateDiscount(price, disFormula);
    total = (price - discount) * amount ~/ 1000;
    notifyListeners();
  }

  updateStockStatus(PurchaseStockStatus newStatus) {
    if (newStatus == purchase.stockStatus) {
      throw 'tidak ada perubahan status stock';
    }
    return purchaseRepo.updateStockStatus(purchase.id, PurchaseUpdateStockStatusModel(newStatus));
  }

  updateStatus(PurchaseStatus newStatus) {
    if (newStatus == purchase.status) {
      throw 'tidak ada perubahan status';
    }
    return purchaseRepo.updateStatus(purchase.id, PurchaseUpdateStatusModel(newStatus));
  }
}
