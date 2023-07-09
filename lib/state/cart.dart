import 'package:flutter/material.dart';
import 'package:sultanpos/model/cart.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/sale.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';
import 'package:sultanpos/state/app.dart';

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
  int curIndex = -1;
  bool saving = false;

  reset() {
    cartModel = CartModel(id: id);
    notifyListeners();
  }

  scanBarcode(String searchSource) async {
    if (searchSource.isEmpty) return;
    final split = searchSource.split("*");
    final barcode = split.length > 1 ? split[1] : split[0];
    int count = 1000;
    if (split.length > 1) {
      final splitCount = int.parse(split[0]);
      count = splitCount * 1000;
    }
    loadingProduct = true;
    notifyListeners();
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
      cartModel.addProduct(count, currentProduct!.priceForAmount(count), "", currentProduct!);
    }
    // currently just use the first data
    loadingProduct = false;
    notifyListeners();
  }

  paySimple(int payment) async {
    final defMethod = await paymentMethodRepo.getDefaultCashMethod();
    final defaultBranch = AppState().shareState.defaultBranch();
    saving = true;
    notifyListeners();
    cartModel.payment = payment;
    try {
      final insert = SaleCashierInsertModel(
          branchId: defaultBranch!.id,
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
      await saleRepository.insertCashier(insert);
      saving = false;
      notifyListeners();
    } catch (e) {
      saving = false;
      notifyListeners();
      rethrow;
    }
  }
}
