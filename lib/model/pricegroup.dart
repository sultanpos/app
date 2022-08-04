import 'package:sultanpos/model/base.dart';

part 'pricegroup.g.dart';

@JsonSerializable()
class PriceGroup implements BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  PriceGroup(this.publicId, this.name, this.isDefault);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroup.fromJson(Map<String, dynamic> json) => _$PriceGroupFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$PriceGroupToJson(this);
}

@JsonSerializable()
class PriceGroupAddRequest implements BaseModel {
  final String name;

  PriceGroupAddRequest(this.name);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupAddRequest.fromJson(Map<String, dynamic> json) => _$PriceGroupAddRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => PriceGroupAddRequest.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupAddRequestToJson(this);
}

@JsonSerializable()
class PriceGroupUpdateRequest implements BaseModel {
  final String name;

  PriceGroupUpdateRequest(this.name);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupUpdateRequest.fromJson(Map<String, dynamic> json) => _$PriceGroupUpdateRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$PriceGroupUpdateRequestToJson(this);
}
