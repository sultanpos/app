import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class ErrorResponse {
  static const int errorCodeCanceled = -1;
  static const int errorCodeTimeout = -2;
  static const int errorCodeOther = -3;
  static const int errorConnection = -4;
  static const int errorBadCertificate = -5;
  static const int errorUnknown = -99;

  int code;
  String message;
  ErrorResponse(this.code, this.message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
