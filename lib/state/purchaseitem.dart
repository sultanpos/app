import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/purchase.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';
import 'package:sultanpos/state/crud.dart';
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
      final products = await productRepo.query(RestFilterModel(limit: 10, offset: 0, queryParameters: {
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
      purchase = await purchaseRepo.get(purchase.id);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
