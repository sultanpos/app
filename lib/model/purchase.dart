import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/product.dart';

part 'purchase.g.dart';

enum PurchaseType implements Comparable<PurchaseType> {
  @JsonValue('po')
  po('po', 'PO'),
  @JsonValue('normal')
  normal('normal', 'Normal');

  final String value;
  final String text;
  const PurchaseType(this.value, this.text);

  @override
  int compareTo(PurchaseType other) {
    return index - other.index;
  }
}

enum PurchaseStatus implements Comparable<PurchaseStatus> {
  @JsonValue('draft')
  draft('draft', 'Draft'),
  @JsonValue('validated')
  validated('validate', 'Tervalidasi'),
  @JsonValue('in_progress')
  inProgress('in_progress', 'Process'),
  @JsonValue('done')
  done('done', 'Selesai');

  final String value;
  final String text;
  const PurchaseStatus(this.value, this.text);

  @override
  int compareTo(PurchaseStatus other) {
    return index - other.index;
  }
}

enum PurchaseStockStatus implements Comparable<PurchaseStockStatus> {
  @JsonValue('none')
  none('none', 'Belum'),
  @JsonValue('transit')
  transit('transit', 'Transit'),
  @JsonValue('received')
  received('received', 'Diterima');

  final String value;
  final String text;
  const PurchaseStockStatus(this.value, this.text);

  @override
  int compareTo(PurchaseStockStatus other) {
    return index - other.index;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PurchaseModel extends BaseModel {
  final int id;
  final DateTime date;
  final String refNumber;
  final String number;
  final PurchaseType type;
  final PurchaseStatus status;
  final PurchaseStockStatus stockStatus;
  final int cashierSessionId;
  @JsonKey(name: 'subtotal')
  final int subTotal;
  final String discountFormula;
  final int discount;
  final int paymentPaid;
  final int paymentResidual;
  final int total;
  final DateTime deadline;
  final int version;
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

  bool editableStock() {
    return status == PurchaseStatus.validated || status == PurchaseStatus.inProgress;
  }

  bool isPaid() {
    return paymentPaid >= paymentResidual;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseInsertModel extends BaseModel {
  final DateTime date;
  final int branchId;
  final int partnerId;
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

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseUpdateModel extends BaseModel {
  final DateTime date;
  final int branchId;
  final int partnerId;
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

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseItemModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
  final int id;
  final int amount;
  final int buyPrice;
  final int price;
  final int subtotal;
  final String discountFormula;
  final int discount;
  final int total;
  final String note;
  final int serialStockId;
  final ProductModel? product;

  PurchaseItemModel(this.id, this.amount, this.buyPrice, this.price, this.subtotal, this.discountFormula, this.discount,
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

  @override
  int getId() => id;
}

@JsonSerializable()
class PurchaseUpdateStockStatusModel extends BaseModel {
  @JsonKey(name: 'stock_status')
  final PurchaseStockStatus stockStatus;
  PurchaseUpdateStockStatusModel(this.stockStatus);

  factory PurchaseUpdateStockStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseUpdateStockStatusModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PurchaseUpdateStockStatusModelToJson(this);
}

@JsonSerializable()
class PurchaseUpdateStatusModel extends BaseModel {
  final PurchaseStatus status;
  PurchaseUpdateStatusModel(this.status);

  factory PurchaseUpdateStatusModel.fromJson(Map<String, dynamic> json) => _$PurchaseUpdateStatusModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PurchaseUpdateStatusModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseItemInsertModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
  final int serialStockId;
  final int productId;
  final int amount;
  final int price;
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

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseItemUpdateModel extends BaseModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? purchaseId;
  final int productId;
  final int amount;
  final int price;
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
