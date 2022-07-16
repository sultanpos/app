import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginUsernamePasswordRequest {
  String username;
  String password;
  LoginUsernamePasswordRequest(this.username, this.password);

  factory LoginUsernamePasswordRequest.fromJson(Map<String, dynamic> json) => _$LoginUsernamePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUsernamePasswordRequestToJson(this);
}
