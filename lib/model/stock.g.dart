// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['stock'] as int,
      json['product_id'] as int,
      json['branch_id'] as int,
      json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'stock': instance.stock,
      'product_id': instance.productId,
      'branch_id': instance.branchId,
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
