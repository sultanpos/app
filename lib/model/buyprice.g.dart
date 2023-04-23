// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyprice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyPriceModel _$BuyPriceModelFromJson(Map<String, dynamic> json) =>
    BuyPriceModel(
      json['id'] as int,
      json['buy_price'] as int,
      json['last_buy_price'] as int,
      BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuyPriceModelToJson(BuyPriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buy_price': instance.buyPrice,
      'last_buy_price': instance.lastBuyPrice,
      'branch': instance.branch,
    };
