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
      json['firebase_token'] as String,
    );

Map<String, dynamic> _$LoginFirebaseTokenRequestToJson(
        LoginFirebaseTokenRequest instance) =>
    <String, dynamic>{
      'firebase_token': instance.firebaseToken,
    };

LoginRefreshToken _$LoginRefreshTokenFromJson(Map<String, dynamic> json) =>
    LoginRefreshToken(
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$LoginRefreshTokenToJson(LoginRefreshToken instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['access_token'] as String,
      json['refresh_token'] as String,
      json['expires_in'] as int,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
    };
