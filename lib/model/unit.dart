import 'package:sultanpos/model/base.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit implements BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;

  Unit(this.publicId, this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

@JsonSerializable()
class UnitAddRequest implements BaseModel {
  final String name;

  UnitAddRequest(this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitAddRequest.fromJson(Map<String, dynamic> json) => _$UnitAddRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => Unit.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitAddRequestToJson(this);
}

@JsonSerializable()
class UnitUpdateRequest implements BaseModel {
  final String name;

  UnitUpdateRequest(this.name);

  @override
  String? path() {
    return "/unit";
  }

  @override
  factory UnitUpdateRequest.fromJson(Map<String, dynamic> json) => _$UnitUpdateRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$UnitUpdateRequestToJson(this);
}
