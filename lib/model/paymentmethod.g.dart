// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentmethod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) =>
    PaymentMethodModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['branch_id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['additional'] as String,
      $enumDecode(_$PaymentMethodTypeEnumMap, json['method']),
      json['is_default'] as bool,
    );

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'branch_id': instance.branchId,
      'name': instance.name,
      'description': instance.description,
      'additional': instance.additional,
      'method': _$PaymentMethodTypeEnumMap[instance.method]!,
      'is_default': instance.isDefault,
    };

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.edc: 'edc',
  PaymentMethodType.transfer: 'transfer',
  PaymentMethodType.online: 'online',
};

PaymentMethodInsertModel _$PaymentMethodInsertModelFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodInsertModel(
      json['branch_id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['additional'] as int,
      $enumDecode(_$PaymentMethodTypeEnumMap, json['method']),
    );

Map<String, dynamic> _$PaymentMethodInsertModelToJson(
        PaymentMethodInsertModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'name': instance.name,
      'description': instance.description,
      'additional': instance.additional,
      'method': _$PaymentMethodTypeEnumMap[instance.method]!,
    };

PaymentMethodUpdateModel _$PaymentMethodUpdateModelFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodUpdateModel(
      json['branch_id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['additional'] as int,
      $enumDecode(_$PaymentMethodTypeEnumMap, json['method']),
    );

Map<String, dynamic> _$PaymentMethodUpdateModelToJson(
        PaymentMethodUpdateModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'name': instance.name,
      'description': instance.description,
      'additional': instance.additional,
      'method': _$PaymentMethodTypeEnumMap[instance.method]!,
    };
