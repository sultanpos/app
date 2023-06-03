import 'package:flutter/material.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/list.dart';
import 'package:sultanpos/state/product.dart';

class ProductRootState extends ChangeNotifier {
  final HttpAPI httpApi;
  ListHttpState<ProductModel> productList;
  String? currentId;
  List<ProductState> items = [];

  ProductRootState(this.httpApi)
      : productList = ListHttpState<ProductModel>(httpApi, "/product", ProductModel.fromJson);

  setCurrentId(String value) {
    currentId = value;
    notifyListeners();
  }

  addNew() {
    final idx = items.indexWhere((element) => element.getId() == "add");
    currentId = "add";
    if (idx >= 0) {
      notifyListeners();
      return;
    }
    items.add(ProductState(httpApi));
    notifyListeners();
  }

  ProductState productWidgetWithId(String id) {
    return items.firstWhere((element) => element.getId() == id);
  }

  closeTab(String id) {
    final index = items.indexWhere((element) => element.getId() == id);
    items.removeAt(index);
    currentId = items.isEmpty
        ? null
        : index >= items.length
            ? items[index - 1].getId()
            : items[index].getId();
    notifyListeners();
  }

  editProduct(ProductModel value) {
    final p = ProductState(httpApi);
    p.editForm(value);
    items.add(p);
    currentId = p.getId();
    notifyListeners();
  }

  deleteProduct(int id) async {
    await httpApi.delete('/product/$id');
    productList.load(refresh: true);
  }
}
