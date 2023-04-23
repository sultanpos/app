import 'package:sultanpos/model/base.dart';

part 'pricegroup.g.dart';

@JsonSerializable()
class PriceGroupModel extends BaseModel {
  final int id;
  final String name;
  final String description;
  @JsonKey(name: 'public_description')
  final String publicDescription;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  PriceGroupModel(this.id, this.name, this.description, this.publicDescription, this.isDefault);

  @override
  String? path() {
    return "/pricegroup";
  }

  @override
  factory PriceGroupModel.fromJson(Map<String, dynamic> json) => _$PriceGroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceGroupModelToJson(this);

  @override
  int getId() => id;
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
