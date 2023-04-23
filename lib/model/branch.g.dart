// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      json['id'] as int,
      json['name'] as String,
      json['code'] as String,
      json['fullname'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['npwp'] as String,
      json['image'] as String,
      json['is_default'] as bool,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'fullname': instance.fullname,
      'address': instance.address,
      'phone': instance.phone,
      'npwp': instance.npwp,
      'image': instance.image,
      'is_default': instance.isDefault,
    };
