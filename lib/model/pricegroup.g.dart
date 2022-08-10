// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricegroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceGroupModel _$PriceGroupModelFromJson(Map<String, dynamic> json) =>
    PriceGroupModel(
      json['public_id'] as String,
      json['name'] as String,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$PriceGroupModelToJson(PriceGroupModel instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'name': instance.name,
      'is_default': instance.isDefault,
    };

PriceGroupAddRequestModel _$PriceGroupAddRequestModelFromJson(
        Map<String, dynamic> json) =>
    PriceGroupAddRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupAddRequestModelToJson(
        PriceGroupAddRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

PriceGroupUpdateRequestModel _$PriceGroupUpdateRequestModelFromJson(
        Map<String, dynamic> json) =>
    PriceGroupUpdateRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupUpdateRequestModelToJson(
        PriceGroupUpdateRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
