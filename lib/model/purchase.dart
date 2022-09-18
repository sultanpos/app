import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/partner.dart';

part 'purchase.g.dart';

@JsonSerializable(explicitToJson: true)
class PurchaseModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final String number;
  final String type;
  final String status;
  @JsonKey(name: 'subtotal')
  final int subTotal;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final int discount;
  @JsonKey(name: 'payment_paid')
  final int paymentPaid;
  @JsonKey(name: 'payment_residual')
  final int paymentResidual;
  final int total;
  final BranchModel branch;
  final PartnerModel partner;

  PurchaseModel(
    this.publicId,
    this.number,
    this.type,
    this.status,
    this.subTotal,
    this.discountFormula,
    this.discount,
    this.paymentPaid,
    this.paymentResidual,
    this.total,
    this.branch,
    this.partner,
  );

  @override
  String? path() {
    return "/purchase";
  }

  @override
  factory PurchaseModel.fromJson(Map<String, dynamic> json) => _$PurchaseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);

  @override
  String getPublicId() => publicId;
}

@JsonSerializable()
class PurchaseInsertModel extends BaseModel {
  final String number;
  final String type;
  final String status;
  @JsonKey(name: 'branch_public_id')
  final String branchPublicId;
  @JsonKey(name: 'partner_public_id')
  final String partnerPublicId;
  @JsonKey(name: 'user_public_id')
  final String userPublicId;
  @JsonKey(includeIfNull: true)
  final DateTime? deadline;

  PurchaseInsertModel(
    this.number,
    this.type,
    this.status,
    this.branchPublicId,
    this.partnerPublicId,
    this.userPublicId,
    this.deadline,
  );

  @override
  String? path() {
    return "/purchase";
  }

  @override
  factory PurchaseInsertModel.fromJson(Map<String, dynamic> json) => _$PurchaseInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseInsertModelToJson(this);
}
