export 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  BaseModel();
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;
  int getId() => 0;
  String? path() => null;
}

abstract class BaseFilterModel<T> {}
