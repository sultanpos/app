import 'package:sultanpos/model/base.dart';

part 'unit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UnitModel extends LocalSqlBase {
  final int id;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String description;

  UnitModel(this.id, this.updatedAt, this.deletedAt, this.name, this.description);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);

  factory UnitModel.empty() => UnitModel(0, DateTime.now(), null, '', '');

  @override
  Map<String, dynamic> toJson() => _$UnitModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "unit";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() => _$UnitModelToJson(this);

  @override
  factory UnitModel.fromSqlite(Map<String, dynamic> json) => _$UnitModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UnitAddRequestModel extends BaseModel {
  final String name;
  final String description;

  UnitAddRequestModel(this.name, this.description);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitAddRequestModel.fromJson(Map<String, dynamic> json) => _$UnitAddRequestModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => UnitModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitAddRequestModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UnitUpdateRequestModel extends BaseModel {
  final String name;
  final String description;

  UnitUpdateRequestModel(this.name, this.description);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitUpdateRequestModel.fromJson(Map<String, dynamic> json) => _$UnitUpdateRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitUpdateRequestModelToJson(this);
}
