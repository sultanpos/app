import 'package:sultanpos/model/base.dart';

part 'pricegroup.g.dart';

@JsonSerializable()
class PriceGroupModel extends LocalSqlBase {
  final int id;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String name;
  final String description;
  @JsonKey(name: 'public_description')
  final String publicDescription;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  PriceGroupModel(
      this.id, this.updatedAt, this.deletedAt, this.name, this.description, this.publicDescription, this.isDefault);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupModel.fromJson(Map<String, dynamic> json) => _$PriceGroupModelFromJson(json);

  factory PriceGroupModel.empty() => PriceGroupModel(0, DateTime.now(), null, '', '', '', false);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "pricegroup";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() {
    final ret = _$PriceGroupModelToJson(this);
    ret["is_default"] = ret["is_default"] ? 1 : 0;
    return ret;
  }

  @override
  factory PriceGroupModel.fromSqlite(Map<String, dynamic> json) {
    final newJson = Map<String, dynamic>.from(json);
    newJson["is_default"] = json["is_default"] != 0;
    return _$PriceGroupModelFromJson(newJson);
  }
}

@JsonSerializable()
class PriceGroupAddRequestModel extends BaseModel {
  final String name;
  final String description;
  @JsonKey(name: 'public_description')
  final String publicDescription;

  PriceGroupAddRequestModel(this.name, this.description, this.publicDescription);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupAddRequestModel.fromJson(Map<String, dynamic> json) => _$PriceGroupAddRequestModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => PriceGroupAddRequestModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupAddRequestModelToJson(this);
}

@JsonSerializable()
class PriceGroupUpdateRequestModel extends BaseModel {
  final String name;
  final String description;
  @JsonKey(name: 'public_description')
  final String publicDescription;

  PriceGroupUpdateRequestModel(this.name, this.description, this.publicDescription);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PriceGroupUpdateRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupUpdateRequestModelToJson(this);
}
