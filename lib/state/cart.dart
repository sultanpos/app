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
  final int id;
  final int cashierSessionId;
  CartState(this.id, {required this.productRepo, required this.paymentMethodRepo, this.cashierSessionId = 0})
      : cartModel = CartModel(id: id);

  bool loadingProduct = false;
  ProductModel? currentProduct;
  List<ProductModel> currentListProduct = [];
  CartModel cartModel;
  int curIndex = -1;

  scanBarcode(String searchSource) async {
    if (searchSource.isEmpty) return;
    final split = searchSource.split("*");
    final barcode = split.length > 1 ? split[1] : split[0];
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
      cartModel.addProduct(1000, currentProduct!.priceForAmount(1000), "", currentProduct!);
    }
    // currently just use the first data
    loadingProduct = false;
    notifyListeners();
  }

  paySimple(int payment) async {
    final defMethod = await paymentMethodRepo.getDefaultCashMethod();
    final insert = SaleCashierInsertModel(
        date: DateTime.now(),
        cashierSessionId: cashierSessionId,
        deadline: null,
        discount: 0,
        discountFormula: '',
        number: '',
        partnerId: 0,
        subtotal: cartModel.total(),
        total: cartModel.total(),
        version: 0,
        userId: AppState().authState.user!.id,
        payments: [
          PaymentCashierInsertModel(
            amount: cartModel.total(),
            payment: payment,
            changes: cartModel.total() - payment,
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
    print(insert);
  }
}
