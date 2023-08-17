// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['price_group_id'] as int,
      json['product_id'] as int,
      json['count0'] as int,
      json['price0'] as int,
      json['discount_formula0'] as String,
      json['discount0'] as int,
      json['count1'] as int,
      json['price1'] as int,
      json['discount_formula1'] as String,
      json['discount1'] as int,
      json['count2'] as int,
      json['price2'] as int,
      json['discount_formula2'] as String,
      json['discount2'] as int,
      json['count3'] as int,
      json['price3'] as int,
      json['discount_formula3'] as String,
      json['discount3'] as int,
      json['count4'] as int,
      json['price4'] as int,
      json['discount_formula4'] as String,
      json['discount4'] as int,
      json['price_group'] == null
          ? null
          : PriceGroupModel.fromJson(
              json['price_group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'price_group_id': instance.priceGroupId,
      'product_id': instance.productId,
      'count0': instance.count0,
      'price0': instance.price0,
      'discount_formula0': instance.discountFormula0,
      'discount0': instance.discount0,
      'count1': instance.count1,
      'price1': instance.price1,
      'discount_formula1': instance.discountFormula1,
      'discount1': instance.discount1,
      'count2': instance.count2,
      'price2': instance.price2,
      'discount_formula2': instance.discountFormula2,
      'discount2': instance.discount2,
      'count3': instance.count3,
      'price3': instance.price3,
      'discount_formula3': instance.discountFormula3,
      'discount3': instance.discount3,
      'count4': instance.count4,
      'price4': instance.price4,
      'discount_formula4': instance.discountFormula4,
      'discount4': instance.discount4,
      'price_group': instance.priceGroup,
    };
