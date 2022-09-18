import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/model/request.dart';

part 'partner.g.dart';

@JsonSerializable(explicitToJson: true)
class PartnerModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  @JsonKey(name: 'is_supplier')
  final bool isSupplier;
  @JsonKey(name: 'is_customer')
  final bool isCustomer;
  final String number;
  final String name;
  final String address;
  final String phone;
  final String npwp;
  final String email;
  final int debt;
  final int credit;
  @JsonKey(name: 'price_group')
  final PriceGroupModel? priceGroup;

  PartnerModel(this.publicId, this.isSupplier, this.isCustomer, this.number, this.name, this.address, this.phone, this.npwp, this.email, this.debt,
      this.credit, this.priceGroup);

  @override
  String? path() {
    return "/partner";
  }

  @override
  factory PartnerModel.fromJson(Map<String, dynamic> json) => _$PartnerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartnerModelToJson(this);

  @override
  String getPublicId() => publicId;
}

@JsonSerializable()
class PartnerInsertModel extends BaseModel {
  @JsonKey(name: 'is_supplier')
  final bool isSupplier;
  @JsonKey(name: 'is_customer')
  final bool isCustomer;
  final String name;
  final String address;
  final String phone;
  final String npwp;
  final String email;
  @JsonKey(name: 'price_group_public_id')
  final String priceGroupPublicId;

  PartnerInsertModel(this.isSupplier, this.isCustomer, this.name, this.address, this.phone, this.npwp, this.email, this.priceGroupPublicId);

  @override
  String? path() {
    return "/partner";
  }

  @override
  factory PartnerInsertModel.fromJson(Map<String, dynamic> json) => _$PartnerInsertModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => InsertSuccessModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartnerInsertModelToJson(this);
}

@JsonSerializable()
class PartnerUpdateModel extends BaseModel {
  @JsonKey(name: 'is_supplier')
  final bool isSupplier;
  @JsonKey(name: 'is_customer')
  final bool isCustomer;
  final String name;
  final String address;
  final String phone;
  final String npwp;
  final String email;
  @JsonKey(name: 'price_group_public_id')
  final String priceGroupPublicId;

  PartnerUpdateModel(this.isSupplier, this.isCustomer, this.name, this.address, this.phone, this.npwp, this.email, this.priceGroupPublicId);

  @override
  String? path() {
    return "/partner";
  }

  @override
  factory PartnerUpdateModel.fromJson(Map<String, dynamic> json) => _$PartnerUpdateModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => UpdateSuccessModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartnerUpdateModelToJson(this);
}
