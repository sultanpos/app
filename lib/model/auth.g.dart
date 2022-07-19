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

LoginFirebaseTokenRequest _$LoginFirebaseTokenRequestFromJson(
        Map<String, dynamic> json) =>
    LoginFirebaseTokenRequest(
      json['firebaseToken'] as String,
    );

Map<String, dynamic> _$LoginFirebaseTokenRequestToJson(
        LoginFirebaseTokenRequest instance) =>
    <String, dynamic>{
      'firebaseToken': instance.firebaseToken,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['accessToken'] as String,
      json['refreshToken'] as String,
      json['expiresIn'] as int,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
