import 'package:flutter/material.dart';
import 'package:sultanpos/model/cart.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/request.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';
import 'package:sultanpos/state/app.dart';

class ScanResult {
  String barcode;
  bool found;
  String? error;
  ScanResult(this.barcode, this.found, {this.error});
}

class CartState extends ChangeNotifier {
  final ProductRepository productRepo;
  final PaymentMethodRepository paymentMethodRepo;
  final SaleRepository saleRepository;
  final int id;
  final int cashierSessionId;
  CartState(
    this.id, {
    required this.productRepo,
    required this.paymentMethodRepo,
    required this.saleRepository,
    this.cashierSessionId = 0,
  }) : cartModel = CartModel(id: id);

  bool loadingProduct = false;
  ProductModel? currentProduct;
  List<ProductModel> currentListProduct = [];
  CartModel cartModel;
  int curIndex = 0;
  int lastSale = 0;
  bool saving = false;

  reset() {
    cartModel = CartModel(id: id);
    notifyListeners();
  }

  Future<ScanResult> scanBarcode(String searchSource) async {
    ScanResult result = ScanResult(searchSource, false);
    if (searchSource.isEmpty) return ScanResult('', false, error: 'empty barcode');
    final split = searchSource.split("*");
    final barcode = split.length > 1 ? split[1] : split[0];
    int count = 1000;
    if (split.length > 1) {
      final splitCount = int.parse(split[0]);
      count = splitCount * 1000;
    }
    loadingProduct = true;
    result.barcode = barcode;
    notifyListeners();
    try {
      final productResult = await productRepo.query(
        RestFilterModel(
          limit: 10,
          offset: 0,
          queryParameters: {'barcode': barcode},
        ),
      );
      currentListProduct = productResult.data;
      if (currentListProduct.isNotEmpty) {
        currentProduct = currentListProduct.first;
        cartModel.addProduct(
            count, currentProduct!.priceForAmount(cartModel.amount(currentProduct!) + count), "", currentProduct!);
      }
      // currently just use the first data
      loadingProduct = false;
      notifyListeners();
      curIndex = 0;
      result.found = currentListProduct.isNotEmpty;
    } catch (e) {
      result.error = e.toString();
      loadingProduct = false;
      notifyListeners();
    }
    return result;
  }

  Future<InsertSuccessModel> paySimple(int payment) async {
    final defMethod = await paymentMethodRepo.getDefaultCashMethod();
    final branch = AppState().global.currentBranch!;
    saving = true;
    notifyListeners();
    cartModel.payment = payment;
    try {
      final insert = SaleCashierInsertModel(
          branchId: branch.id,
          date: DateTime.now().toUtc(),
          cashierSessionId: cashierSessionId,
          deadline: null,
          discount: 0,
          discountFormula: '',
          number: '',
          partnerId: 0,
          subtotal: cartModel.getTotal(),
          total: cartModel.getTotal(),
          version: 0,
          userId: AppState().authState.user!.id,
          payments: [
            PaymentCashierInsertModel(
              amount: cartModel.getTotal(),
              payment: payment,
              changes: cartModel.getTotal() - payment,
              paymentMethodID: defMethod.id,
              reference: '',
              note: '',
            ),
          ],
          items: cartModel.items
              .map<SaleItemInsertModel>((e) => SaleItemInsertModel(
                    batch: 0,
                    amount: e.amount(),
                    discount: e.discount(),
                    discountFormula: e.discountFormula(),
                    price: e.price(),
                    productId: e.product.id,
                    subtotal: e.subtotal(),
                    note: '',
                    total: e.total(),
                  ))
              .toList());
      final result = await saleRepository.insertCashier(insert);
      saving = false;
      notifyListeners();
      lastSale = result.id;
      return result;
    } catch (e) {
      saving = false;
      notifyListeners();
      rethrow;
    }
  }

  nextItem() {
    if (curIndex < cartModel.items.length - 1) {
      curIndex++;
      notifyListeners();
    }
  }

  prevItem() {
    if (curIndex > 0) {
      curIndex--;
      notifyListeners();
    }
  }

  removeItem() {
    cartModel.removeItemByIndex(curIndex);
    if (curIndex > cartModel.items.length - 1) {
      curIndex = cartModel.items.length - 1;
    }
    notifyListeners();
  }
}
