// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['public_id'] as String,
      json['username'] as String,
      json['name'] as String,
      json['email'] as String,
      json['pin'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['photo'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'public_id': instance.publicID,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'pin': instance.pin,
      'address': instance.address,
      'phone': instance.phone,
      'photo': instance.photo,
    };
