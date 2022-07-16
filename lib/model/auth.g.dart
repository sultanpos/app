// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUsernamePasswordRequest _$LoginUsernamePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    LoginUsernamePasswordRequest(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginUsernamePasswordRequestToJson(
        LoginUsernamePasswordRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
