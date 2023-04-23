import 'package:sultanpos/model/base.dart';

part 'unit.g.dart';

@JsonSerializable()
class UnitModel extends BaseModel {
  final int id;
  final String name;
  final String description;

  UnitModel(this.id, this.name, this.description);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitModelToJson(this);

  @override
  int getId() => id;
}

@JsonSerializable()
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

@JsonSerializable()
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
