// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'] as int,
    )..items = (json['items'] as List<dynamic>)
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      itemAmount: json['itemAmount'] as int,
      itemPrice: json['itemPrice'] as int,
      itemDiscountFormula: json['itemDiscountFormula'] as String,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'itemAmount': instance.itemAmount,
      'itemPrice': instance.itemPrice,
      'itemDiscountFormula': instance.itemDiscountFormula,
    };
