import 'package:sultanpos/model/base.dart';

part 'pricegroup.g.dart';

@JsonSerializable()
class PriceGroupModel implements BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  PriceGroupModel(this.publicId, this.name, this.isDefault);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupModel.fromJson(Map<String, dynamic> json) => _$PriceGroupFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$PriceGroupToJson(this);
}

@JsonSerializable()
class PriceGroupAddRequestModel implements BaseModel {
  final String name;

  PriceGroupAddRequestModel(this.name);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupAddRequestModel.fromJson(Map<String, dynamic> json) => _$PriceGroupAddRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => PriceGroupAddRequestModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupAddRequestToJson(this);
}

@JsonSerializable()
class PriceGroupUpdateRequestModel implements BaseModel {
  final String name;

  PriceGroupUpdateRequestModel(this.name);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupUpdateRequestModel.fromJson(Map<String, dynamic> json) => _$PriceGroupUpdateRequestFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() => _$PriceGroupUpdateRequestToJson(this);
}
