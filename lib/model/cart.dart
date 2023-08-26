import 'package:json_annotation/json_annotation.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/util/calculate.dart';

part 'cart.g.dart';

abstract class ICartItem {
  int id();
  String name();
  String barcode();
  String unit();
  int amount();
  int price();
  int discount();
  ICartItem addAmountAndPrice(int amount, int price);
  String discountFormula();
  int subtotal();
  int total();
}

abstract class ICart {
  ICartItem itemAt(int index);
  void removeItemByIndex(int index);
  void removeItem(ICartItem item);
  void addItem(ICartItem item);
  int itemLength();
  int getTotal();
  int getChange();
  int getPayment();
}

@JsonSerializable(explicitToJson: true)
class CartModel implements ICart {
  int id;
  int _payment = 0;
  List<CartItemModel> items = [];
  CartModel({required this.id});
  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  set payment(int value) => _payment = value;

  @override
  int getTotal() {
    return items.fold(0, (previousValue, element) => previousValue + element.total());
  }

  addProduct(int amount, int price, String discountFormula, ProductModel product) {
    //check if contains product already
    int index = items.indexWhere((element) => element.id() == product.id);
    if (index >= 0) {
      final item = items[index].addAmountAndPrice(amount, price);
      items.removeAt(index);
      items.insert(0, item);
    } else {
      items.insert(
        0,
        CartItemModel(
          product: product,
          itemAmount: amount,
          itemPrice: price,
          itemDiscountFormula: discountFormula,
        ),
      );
    }
  }

  int amount(ProductModel product) {
    int index = items.indexWhere((element) => element.id() == product.id);
    if (index >= 0) {
      return items[index].itemAmount;
    }
    return 0;
  }

  bool isEmpty() {
    return items.isEmpty;
  }

  @override
  void addItem(ICartItem item) {
    // TODO: implement addItem
  }

  @override
  ICartItem itemAt(int index) {
    return items[index];
  }

  @override
  int itemLength() {
    return items.length;
  }

  @override
  void removeItem(ICartItem item) {
    // TODO: implement removeItem
  }

  @override
  void removeItemByIndex(int index) {
    items.removeAt(index);
  }

  @override
  int getChange() {
    return getPayment() - getTotal();
  }

  @override
  int getPayment() {
    return _payment;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CartItemModel implements ICartItem {
  final ProductModel product;
  final int itemAmount;
  final int itemPrice;
  final String itemDiscountFormula;

  CartItemModel({
    required this.product,
    required this.itemAmount,
    required this.itemPrice,
    required this.itemDiscountFormula,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  @override
  int total() {
    return rawCalculateTotal(itemAmount, itemPrice, itemDiscountFormula);
  }

  @override
  String barcode() {
    return product.barcode;
  }

  @override
  int discount() {
    return calculateDiscount(itemPrice, itemDiscountFormula);
  }

  @override
  int id() {
    return product.id;
  }

  @override
  String name() {
    return product.name;
  }

  @override
  String unit() {
    return product.unit?.name ?? '-';
  }

  @override
  int amount() {
    return itemAmount;
  }

  @override
  String discountFormula() {
    return itemDiscountFormula;
  }

  @override
  int price() {
    return itemPrice;
  }

  @override
  CartItemModel addAmountAndPrice(int amount, int price) {
    return CartItemModel(
      product: product,
      itemAmount: itemAmount + amount,
      itemDiscountFormula: itemDiscountFormula,
      itemPrice: price,
    );
  }

  @override
  int subtotal() {
    return rawCalculateTotal(itemAmount, itemPrice, '');
  }
}
