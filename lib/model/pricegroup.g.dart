// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricegroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceGroup _$PriceGroupFromJson(Map<String, dynamic> json) => PriceGroup(
      json['public_id'] as String,
      json['name'] as String,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$PriceGroupToJson(PriceGroup instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'name': instance.name,
      'is_default': instance.isDefault,
    };

PriceGroupAddRequest _$PriceGroupAddRequestFromJson(
        Map<String, dynamic> json) =>
    PriceGroupAddRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupAddRequestToJson(
        PriceGroupAddRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

PriceGroupUpdateRequest _$PriceGroupUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    PriceGroupUpdateRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupUpdateRequestToJson(
        PriceGroupUpdateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
