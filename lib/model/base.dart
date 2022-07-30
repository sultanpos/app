export 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  BaseModel? responseFromJson(Map<String, dynamic> json);
  String? path();
}
