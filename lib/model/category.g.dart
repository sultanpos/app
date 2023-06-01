// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['id'] as int,
      json['name'] as String,
      json['code'] as String,
      json['description'] as String,
      json['parent_id'] as int?,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      json['parent_public_id'] as int,
    );

Map<String, dynamic> _$CategoryInsertModelToJson(
        CategoryInsertModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'parent_public_id': instance.parentParentId,
    };

CategoryUpdateModel _$CategoryUpdateModelFromJson(Map<String, dynamic> json) =>
    CategoryUpdateModel(
      json['name'] as String,
      json['code'] as String,
      json['description'] as String,
      json['parent_public_id'] as int,
    );

Map<String, dynamic> _$CategoryUpdateModelToJson(
        CategoryUpdateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'parent_public_id': instance.parentParentId,
    };
