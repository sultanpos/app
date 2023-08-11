import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/pricegroup.dart';
import 'package:sultanpos/model/request.dart';

part 'partner.g.dart';

@JsonSerializable(explicitToJson: true)
class PartnerModel extends LocalSqlBase {
  final int id;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
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
  @JsonKey(name: 'price_group_id')
  final int priceGroupId;
  @JsonKey(name: 'price_group')
  final PriceGroupModel? priceGroup;

  PartnerModel(this.id, this.updatedAt, this.deletedAt, this.isSupplier, this.isCustomer, this.number, this.name,
      this.address, this.phone, this.npwp, this.email, this.debt, this.credit, this.priceGroupId, this.priceGroup);

  @override
  String? path() {
    return "/partner";
  }

  @override
  factory PartnerModel.fromJson(Map<String, dynamic> json) => _$PartnerModelFromJson(json);

  factory PartnerModel.empty() =>
      PartnerModel(0, DateTime.now(), null, false, false, '', '', '', '', '', '', 0, 0, 0, null);

  @override
  Map<String, dynamic> toJson() => _$PartnerModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "partner";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() {
    final ret = _$PartnerModelToJson(this);
    ret["is_supplier"] = isSupplier ? 1 : 0;
    ret["is_customer"] = isCustomer ? 1 : 0;
    ret.remove("price_group");
    return ret;
  }

  @override
  factory PartnerModel.fromSqlite(Map<String, dynamic> json) {
    final newJson = Map<String, dynamic>.from(json);
    newJson["is_customer"] = json["is_customer"] != 0;
    newJson["is_supplier"] = json["is_supplier"] != 0;
    return _$PartnerModelFromJson(newJson);
  }
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
  @JsonKey(name: 'price_group_id')
  final int priceGroupId;

  PartnerInsertModel(
      this.isSupplier, this.isCustomer, this.name, this.address, this.phone, this.npwp, this.email, this.priceGroupId);

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
  @JsonKey(name: 'price_group_id')
  final int priceGroupId;

  PartnerUpdateModel(
      this.isSupplier, this.isCustomer, this.name, this.address, this.phone, this.npwp, this.email, this.priceGroupId);

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
