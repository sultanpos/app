// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      json['public_id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'name': instance.name,
    };

UnitAddRequest _$UnitAddRequestFromJson(Map<String, dynamic> json) =>
    UnitAddRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$UnitAddRequestToJson(UnitAddRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

UnitUpdateRequest _$UnitUpdateRequestFromJson(Map<String, dynamic> json) =>
    UnitUpdateRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$UnitUpdateRequestToJson(UnitUpdateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
