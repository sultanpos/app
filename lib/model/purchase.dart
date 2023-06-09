import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/product.dart';

part 'purchase.g.dart';

@JsonSerializable(explicitToJson: true)
class PurchaseModel extends BaseModel {
  final int id;
  final DateTime date;
  @JsonKey(name: 'ref_number')
  final String refNumber;
  final String number;
  final String type;
  final String status;
  @JsonKey(name: 'stock_status')
  final String stockStatus;
  @JsonKey(name: 'cashier_session_id')
  final int cashierSessionId;
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
  final DateTime deadline;
  final int version;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final BranchModel? branch;
  final PartnerModel? partner;
  final List<PurchaseItemModel>? purchaseItems;

  PurchaseModel(
    this.id,
    this.date,
    this.refNumber,
    this.number,
    this.type,
    this.status,
    this.stockStatus,
    this.cashierSessionId,
    this.subTotal,
    this.discountFormula,
    this.discount,
    this.paymentPaid,
    this.paymentResidual,
    this.total,
    this.deadline,
    this.version,
    this.partnerId,
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
  int getId() => id;
}

@JsonSerializable()
class PurchaseInsertModel extends BaseModel {
  final DateTime date;
  @JsonKey(name: 'branch_id')
  final int branchId;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  @JsonKey(name: 'ref_number')
  final String refNumber;
  final String type;
  final DateTime deadline;

  PurchaseInsertModel(
    this.date,
    this.branchId,
    this.partnerId,
    this.refNumber,
    this.type,
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

@JsonSerializable()
class PurchaseUpdateModel extends BaseModel {
  final DateTime date;
  @JsonKey(name: 'branch_id')
  final int branchId;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  @JsonKey(name: 'ref_number')
  final String refNumber;
  final DateTime deadline;

  PurchaseUpdateModel(
    this.date,
    this.branchId,
    this.partnerId,
    this.refNumber,
    this.deadline,
  );

  @override
  String? path() {
    return "/purchase";
  }

  @override
  factory PurchaseUpdateModel.fromJson(Map<String, dynamic> json) => _$PurchaseUpdateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseUpdateModelToJson(this);
}

@JsonSerializable()
class PurchaseItemModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
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
  @JsonKey(name: 'serial_stock_id')
  final int serialStockId;
  final ProductModel? product;

  PurchaseItemModel(this.amount, this.buyPrice, this.price, this.subtotal, this.discountFormula, this.discount,
      this.total, this.note, this.serialStockId, this.product,
      {this.purchaseId});

  @override
  String? path() {
    return "/purchase/$purchaseId/item";
  }

  @override
  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) => _$PurchaseItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseItemModelToJson(this);
}

@JsonSerializable()
class PurchaseItemInsertModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
  @JsonKey(name: "serial_stock_id")
  final int serialStockId;
  @JsonKey(name: "product_id")
  final int productId;
  final int amount;
  final int price;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final String note;

  PurchaseItemInsertModel(this.productId, this.serialStockId, this.amount, this.price, this.discountFormula, this.note,
      {this.purchaseId});

  @override
  String? path() {
    return "/purchase/$purchaseId/item";
  }

  @override
  factory PurchaseItemInsertModel.fromJson(Map<String, dynamic> json) => _$PurchaseItemInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseItemInsertModelToJson(this);
}

@JsonSerializable()
class PurchaseItemUpdateModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
  @JsonKey(name: "product_id")
  final int productId;
  final int amount;
  final int price;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final String note;

  PurchaseItemUpdateModel(this.productId, this.amount, this.price, this.discountFormula, this.note, {this.purchaseId});

  @override
  String? path() {
    return "/purchase/$purchaseId/item";
  }

  @override
  factory PurchaseItemUpdateModel.fromJson(Map<String, dynamic> json) => _$PurchaseItemUpdateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseItemUpdateModelToJson(this);
}
