import 'package:sultanpos/model/base.dart';

part 'unit.g.dart';

@JsonSerializable()
class UnitModel implements BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;

  UnitModel(this.publicId, this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

@JsonSerializable()
class UnitAddRequestModel implements BaseModel {
  final String name;

  UnitAddRequestModel(this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitAddRequestModel.fromJson(Map<String, dynamic> json) => _$UnitAddRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => UnitModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitAddRequestToJson(this);
}

@JsonSerializable()
class UnitUpdateRequestModel implements BaseModel {
  final String name;

  UnitUpdateRequestModel(this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitUpdateRequestModel.fromJson(Map<String, dynamic> json) => _$UnitUpdateRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$UnitUpdateRequestToJson(this);
}
