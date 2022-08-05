// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricegroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceGroupModel _$PriceGroupFromJson(Map<String, dynamic> json) => PriceGroupModel(
      json['public_id'] as String,
      json['name'] as String,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$PriceGroupToJson(PriceGroupModel instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'name': instance.name,
      'is_default': instance.isDefault,
    };

PriceGroupAddRequestModel _$PriceGroupAddRequestFromJson(Map<String, dynamic> json) => PriceGroupAddRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupAddRequestToJson(PriceGroupAddRequestModel instance) => <String, dynamic>{
      'name': instance.name,
    };

PriceGroupUpdateRequestModel _$PriceGroupUpdateRequestFromJson(Map<String, dynamic> json) => PriceGroupUpdateRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$PriceGroupUpdateRequestToJson(PriceGroupUpdateRequestModel instance) => <String, dynamic>{
      'name': instance.name,
    };
