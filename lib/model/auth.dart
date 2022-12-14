import 'package:sultanpos/model/base.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginUsernamePasswordRequest extends BaseModel {
  final String username;
  final String password;

  LoginUsernamePasswordRequest(this.username, this.password);

  @override
  factory LoginUsernamePasswordRequest.fromJson(Map<String, dynamic> json) => _$LoginUsernamePasswordRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginUsernamePasswordRequestToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }

  @override
  String path() {
    return "/auth/login";
  }
}

@JsonSerializable()
class LoginFirebaseTokenRequest extends BaseModel {
  @JsonKey(name: 'firebase_token')
  final String firebaseToken;

  LoginFirebaseTokenRequest(this.firebaseToken);

  @override
  factory LoginFirebaseTokenRequest.fromJson(Map<String, dynamic> json) => _$LoginFirebaseTokenRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginFirebaseTokenRequestToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }

  @override
  String? path() {
    return "/auth/login/firebase";
  }
}

@JsonSerializable()
class LoginRefreshToken extends BaseModel {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  LoginRefreshToken(this.refreshToken);

  @override
  factory LoginRefreshToken.fromJson(Map<String, dynamic> json) => _$LoginRefreshTokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginRefreshTokenToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }

  @override
  String? path() {
    return "/auth/login/refresh";
  }
}

@JsonSerializable()
class LoginResponse extends BaseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  LoginResponse(this.accessToken, this.refreshToken, this.expiresIn);

  @override
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  normalizeDate() {
    final value = DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);
    return LoginResponse(accessToken, refreshToken, value);
  }
}
