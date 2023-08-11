// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
    };

UnitAddRequestModel _$UnitAddRequestModelFromJson(Map<String, dynamic> json) =>
    UnitAddRequestModel(
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$UnitAddRequestModelToJson(
        UnitAddRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

UnitUpdateRequestModel _$UnitUpdateRequestModelFromJson(
        Map<String, dynamic> json) =>
    UnitUpdateRequestModel(
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$UnitUpdateRequestModelToJson(
        UnitUpdateRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
