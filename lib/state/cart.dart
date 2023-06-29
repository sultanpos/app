import 'package:flutter/material.dart';
import 'package:sultanpos/model/cart.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/repository/repository.dart';
import 'package:sultanpos/repository/rest/restrepository.dart';

class CartState extends ChangeNotifier {
  final ProductRepository productRepo;
  final int id;
  CartState(this.id, {required this.productRepo}) : cartModel = CartModel(id: id);

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
}
