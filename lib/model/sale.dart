import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';

part 'sale.g.dart';

enum SaleType implements Comparable<SaleType> {
  @JsonValue('so')
  so('so', 'SO'),
  @JsonValue('normal')
  normal('normal', 'Normal'),
  @JsonValue('cashier')
  cashier('cashier', 'Kasir');

  final String value;
  final String text;
  const SaleType(this.value, this.text);

  @override
  int compareTo(SaleType other) {
    return 0;
  }
}

enum SaleStatus implements Comparable<SaleStatus> {
  @JsonValue('draft')
  draft('draft', 'Draft'),
  @JsonValue('validated')
  validated('validated', 'Tervalidasi'),
  @JsonValue('in_progress')
  inProgress('in_progress', 'Proses'),
  @JsonValue('done')
  done('done', 'Selesai');

  final String value;
  final String text;
  const SaleStatus(this.value, this.text);

  @override
  int compareTo(SaleStatus other) {
    return 0;
  }
}

enum SaleStockStatus implements Comparable<SaleStockStatus> {
  @JsonValue('none')
  none('none', 'Belum'),
  @JsonValue('transit')
  transit('transit', 'Transit'),
  @JsonValue('received')
  received('received', 'Diterima');

  final String value;
  final String text;
  const SaleStockStatus(this.value, this.text);

  @override
  int compareTo(SaleStockStatus other) {
    return 0;
  }
}

@JsonSerializable(explicitToJson: true)
class SaleModel extends BaseModel {
  final int id;
  final DateTime date;
  @JsonKey(name: "branch_id")
  final int branchId;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: 'ref_number')
  final String refNumber;
  final SaleType type;
  final SaleStatus status;
  @JsonKey(name: 'stock_status')
  final SaleStockStatus stockStatus;
  @JsonKey(name: 'cashier_session_id')
  final int cashierSessionId;
  final int subtotal;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final int discount;
  @JsonKey(name: 'payment_paid')
  final int paymentPaid;
  @JsonKey(name: 'payment_residual')
  final int paymentResidual;
  final int total;
  final DateTime? deadline;
  final int version;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final PartnerModel? partner;
  SaleModel(
    this.id,
    this.date,
    this.branchId,
    this.userId,
    this.refNumber,
    this.type,
    this.status,
    this.stockStatus,
    this.cashierSessionId,
    this.subtotal,
    this.discountFormula,
    this.discount,
    this.paymentPaid,
    this.paymentResidual,
    this.total,
    this.deadline,
    this.version,
    this.partnerId,
    this.partner,
  );

  @override
  factory SaleModel.fromJson(Map<String, dynamic> json) => _$SaleModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SaleItemModel extends BaseModel {
  final int id;
  @JsonKey(name: 'sale_id')
  final int saleId;
  @JsonKey(name: 'product_id')
  final int productId;
  final int batch;
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

  SaleItemModel(this.id, this.saleId, this.productId, this.batch, this.amount, this.buyPrice, this.price, this.subtotal,
      this.discountFormula, this.discount, this.total, this.note);

  @override
  factory SaleItemModel.fromJson(Map<String, dynamic> json) => _$SaleItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentCashierInsertModel extends BaseModel {
  final int amount;
  final int payment;
  final int changes;
  @JsonKey(name: 'payment_method_id')
  final int paymentMethodID;
  final String reference;
  final String note;

  PaymentCashierInsertModel(
    this.amount,
    this.payment,
    this.changes,
    this.paymentMethodID,
    this.reference,
    this.note,
  );

  @override
  factory PaymentCashierInsertModel.fromJson(Map<String, dynamic> json) => _$PaymentCashierInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentCashierInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SaleItemInsertModel extends BaseModel {
  final int batch;
  @JsonKey(name: 'product_id')
  final int productId;
  final int amount;
  final int price;
  final int subtotal;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final int discount;
  final int total;
  final int note;

  SaleItemInsertModel(
    this.batch,
    this.productId,
    this.amount,
    this.price,
    this.subtotal,
    this.discountFormula,
    this.discount,
    this.total,
    this.note,
  );

  @override
  factory SaleItemInsertModel.fromJson(Map<String, dynamic> json) => _$SaleItemInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleItemInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SaleCashierInsertModel extends BaseModel {
  final int version;
  final String number;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'cashier_session_id')
  final int cashierSessionId;
  final DateTime date;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final DateTime? deadline;
  @JsonKey(name: 'discount_formula')
  final String discountFormula;
  final int subtotal;
  final int discount;
  final int total;
  final List<SaleItemInsertModel> items;
  final List<PaymentCashierInsertModel> payments;

  SaleCashierInsertModel(
    this.version,
    this.number,
    this.userId,
    this.cashierSessionId,
    this.date,
    this.partnerId,
    this.deadline,
    this.discountFormula,
    this.subtotal,
    this.discount,
    this.total,
    this.items,
    this.payments,
  );

  @override
  factory SaleCashierInsertModel.fromJson(Map<String, dynamic> json) => _$SaleCashierInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleCashierInsertModelToJson(this);
}
