// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricegroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceGroupModel _$PriceGroupModelFromJson(Map<String, dynamic> json) =>
    PriceGroupModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['name'] as String,
      json['description'] as String,
      json['public_description'] as String,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$PriceGroupModelToJson(PriceGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'public_description': instance.publicDescription,
      'is_default': instance.isDefault,
    };

PriceGroupAddRequestModel _$PriceGroupAddRequestModelFromJson(
        Map<String, dynamic> json) =>
    PriceGroupAddRequestModel(
      json['name'] as String,
      json['description'] as String,
      json['public_description'] as String,
    );

Map<String, dynamic> _$PriceGroupAddRequestModelToJson(
        PriceGroupAddRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'public_description': instance.publicDescription,
    };

PriceGroupUpdateRequestModel _$PriceGroupUpdateRequestModelFromJson(
        Map<String, dynamic> json) =>
    PriceGroupUpdateRequestModel(
      json['name'] as String,
      json['description'] as String,
      json['public_description'] as String,
    );

Map<String, dynamic> _$PriceGroupUpdateRequestModelToJson(
        PriceGroupUpdateRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'public_description': instance.publicDescription,
    };
