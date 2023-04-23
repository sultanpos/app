// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      json['id'] as int,
      json['stock'] as int,
      BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stock': instance.stock,
      'branch': instance.branch,
      'product': instance.product,
    };

SerialStockModel _$SerialStockModelFromJson(Map<String, dynamic> json) =>
    SerialStockModel(
      json['id'] as int,
      BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      json['serial_number'] as String,
      json['buy_price'] as int,
      json['sell_price'] as int,
      json['status'] as String,
    );

Map<String, dynamic> _$SerialStockModelToJson(SerialStockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'product': instance.product,
      'serial_number': instance.serialNumber,
      'buy_price': instance.buyPrice,
      'sell_price': instance.sellPrice,
      'status': instance.status,
    };
