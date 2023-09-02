export 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  BaseModel();
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;
  int getId() => 0;
  String? path() => null;
}

class BaseWhereModel {
  final String key;
  final Object? value;
  BaseWhereModel({required this.key, this.value});
}

class BaseFilterModel {
  final int limit;
  final int offset;
  final Map<String, dynamic>? where;
  BaseFilterModel({this.where, this.limit = 100, this.offset = 0});
}

abstract class LocalSqlBase extends BaseModel {
  LocalSqlBase();
  String getTableName();
  DateTime getUpdatedAt();
  Map<String, dynamic> toSqlite();
  LocalSqlBase.fromSqlite(Map<String, dynamic> json);
  bool syncUseBranch() {
    return false;
  }
}
