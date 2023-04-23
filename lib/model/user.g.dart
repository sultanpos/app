// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as int,
      json['username'] as String,
      json['name'] as String,
      json['email'] as String,
      json['pin'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['photo'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'pin': instance.pin,
      'address': instance.address,
      'phone': instance.phone,
      'photo': instance.photo,
    };
