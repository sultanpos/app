import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/stock.dart';

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
  final BranchModel? branch;
  final PartnerModel? partner;
  final List<PurchaseItemModel>? purchaseItems;

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
    this.purchaseItems,
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
  @JsonKey(name: 'purchase_items')
  final List<PurchaseItemModel>? purchaseItems;

  PurchaseInsertModel(
    this.number,
    this.type,
    this.status,
    this.branchPublicId,
    this.partnerPublicId,
    this.userPublicId,
    this.deadline,
    this.purchaseItems,
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

@JsonSerializable()
class PurchaseItemModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final ProductModel product;
  final int amount;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  final int price;
  final int subtotal;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final int discount;
  final int total;
  final String note;
  @JsonKey(name: 'serial_stock')
  final SerialStockModel? serialStock;

  PurchaseItemModel(
    this.publicId,
    this.product,
    this.amount,
    this.buyPrice,
    this.price,
    this.subtotal,
    this.discountFormula,
    this.discount,
    this.total,
    this.note,
    this.serialStock,
  );

  @override
  String? path() {
    return "/purchaseitem";
  }

  @override
  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) => _$PurchaseItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseItemModelToJson(this);
}
