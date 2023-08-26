import 'package:sultanpos/model/base.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginUsernamePasswordRequest extends BaseModel {
  final String username;
  final String password;

  LoginUsernamePasswordRequest(this.username, this.password);

  @override
  factory LoginUsernamePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginUsernamePasswordRequestFromJson(json);

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

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRefreshToken extends BaseModel {
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

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse extends BaseModel {
  final String accessToken;
  final String refreshToken;
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

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequest extends BaseModel {
  final String companyName;
  final String name;
  final String username;
  final String email;
  final String password;

  RegisterRequest(this.companyName, this.name, this.username, this.email, this.password);

  @override
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse extends BaseModel {
  final int userId;
  final int companyId;

  RegisterResponse(this.userId, this.companyId);

  @override
  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
