// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerModel _$PartnerModelFromJson(Map<String, dynamic> json) => PartnerModel(
      json['id'] as int,
      json['is_supplier'] as bool,
      json['is_customer'] as bool,
      json['number'] as String,
      json['name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['npwp'] as String,
      json['email'] as String,
      json['debt'] as int,
      json['credit'] as int,
      json['price_group'] == null
          ? null
          : PriceGroupModel.fromJson(
              json['price_group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerModelToJson(PartnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_supplier': instance.isSupplier,
      'is_customer': instance.isCustomer,
      'number': instance.number,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'npwp': instance.npwp,
      'email': instance.email,
      'debt': instance.debt,
      'credit': instance.credit,
      'price_group': instance.priceGroup?.toJson(),
    };

PartnerInsertModel _$PartnerInsertModelFromJson(Map<String, dynamic> json) =>
    PartnerInsertModel(
      json['is_supplier'] as bool,
      json['is_customer'] as bool,
      json['name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['npwp'] as String,
      json['email'] as String,
      json['price_group_id'] as int,
    );

Map<String, dynamic> _$PartnerInsertModelToJson(PartnerInsertModel instance) =>
    <String, dynamic>{
      'is_supplier': instance.isSupplier,
      'is_customer': instance.isCustomer,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'npwp': instance.npwp,
      'email': instance.email,
      'price_group_id': instance.priceGroupId,
    };

PartnerUpdateModel _$PartnerUpdateModelFromJson(Map<String, dynamic> json) =>
    PartnerUpdateModel(
      json['is_supplier'] as bool,
      json['is_customer'] as bool,
      json['name'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['npwp'] as String,
      json['email'] as String,
      json['price_group_id'] as int,
    );

Map<String, dynamic> _$PartnerUpdateModelToJson(PartnerUpdateModel instance) =>
    <String, dynamic>{
      'is_supplier': instance.isSupplier,
      'is_customer': instance.isCustomer,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'npwp': instance.npwp,
      'email': instance.email,
      'price_group_id': instance.priceGroupId,
    };
