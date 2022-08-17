export 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  BaseModel();
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;
  String? path() => null;
  String getPublicId() => "";
}
