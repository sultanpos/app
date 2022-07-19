import 'package:json_annotation/json_annotation.dart';
import 'package:sultanpos/model/base.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginUsernamePasswordRequest implements BaseModel {
  String username;
  String password;

  LoginUsernamePasswordRequest(this.username, this.password);

  @override
  factory LoginUsernamePasswordRequest.fromJson(Map<String, dynamic> json) => _$LoginUsernamePasswordRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginUsernamePasswordRequestToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }
}

@JsonSerializable()
class LoginFirebaseTokenRequest implements BaseModel {
  String firebaseToken;

  LoginFirebaseTokenRequest(this.firebaseToken);

  @override
  factory LoginFirebaseTokenRequest.fromJson(Map<String, dynamic> json) => _$LoginFirebaseTokenRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginFirebaseTokenRequestToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }
}

@JsonSerializable()
class LoginResponse implements BaseModel {
  String accessToken;
  String refreshToken;
  int expiresIn;

  LoginResponse(this.accessToken, this.refreshToken, this.expiresIn);

  @override
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return null;
  }
}
