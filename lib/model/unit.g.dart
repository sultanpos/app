// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitFromJson(Map<String, dynamic> json) => UnitModel(
      json['public_id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$UnitToJson(UnitModel instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'name': instance.name,
    };

UnitAddRequestModel _$UnitAddRequestFromJson(Map<String, dynamic> json) => UnitAddRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$UnitAddRequestToJson(UnitAddRequestModel instance) => <String, dynamic>{
      'name': instance.name,
    };

UnitUpdateRequestModel _$UnitUpdateRequestFromJson(Map<String, dynamic> json) => UnitUpdateRequestModel(
      json['name'] as String,
    );

Map<String, dynamic> _$UnitUpdateRequestToJson(UnitUpdateRequestModel instance) => <String, dynamic>{
      'name': instance.name,
    };
