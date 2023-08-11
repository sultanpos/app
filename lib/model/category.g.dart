// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['name'] as String,
      json['code'] as String,
      json['description'] as String,
      json['parent_id'] as int?,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'parent_id': instance.parentId,
      'is_default': instance.isDefault,
    };

CategoryInsertModel _$CategoryInsertModelFromJson(Map<String, dynamic> json) =>
    CategoryInsertModel(
      json['name'] as String,
      json['code'] as String,
      json['description'] as String,
      json['parent_id'] as int,
    );

Map<String, dynamic> _$CategoryInsertModelToJson(
        CategoryInsertModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'parent_id': instance.parentId,
    };

CategoryUpdateModel _$CategoryUpdateModelFromJson(Map<String, dynamic> json) =>
    CategoryUpdateModel(
      json['name'] as String,
      json['code'] as String,
      json['description'] as String,
      json['parent_id'] as int,
    );

Map<String, dynamic> _$CategoryUpdateModelToJson(
        CategoryUpdateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'parent_id': instance.parentId,
    };
