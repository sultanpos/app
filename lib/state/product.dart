import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/state/base.dart';
import 'package:sultanpos/state/list.dart';

class ProductState extends BaseState {
  ProductState(super.httpAPI) : listData = ListState<ProductModel>(httpAPI, '/product', ProductModel.fromJson);

  ListState<ProductModel> listData;

  int currentIndex = 0;

  setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
