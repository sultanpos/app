import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';

part 'sale.g.dart';

enum SaleType implements Comparable<SaleType> {
  @JsonValue('so')
  so('SO'),
  @JsonValue('normal')
  normal('Normal'),
  @JsonValue('cashier')
  cashier('Kasir');

  final String value;
  const SaleType(this.value);

  @override
  int compareTo(SaleType other) {
    return 0;
  }
}

enum SaleStatus implements Comparable<SaleStatus> {
  @JsonValue('draft')
  draft('Draft'),
  @JsonValue('validated')
  validated('Tervalidasi'),
  @JsonValue('in_progress')
  inProgress('Proses'),
  @JsonValue('done')
  done('Selesai');

  final String value;
  const SaleStatus(this.value);

  @override
  int compareTo(SaleStatus other) {
    return 0;
  }
}

enum SaleStockStatus implements Comparable<SaleStockStatus> {
  @JsonValue('none')
  none('Belum'),
  @JsonValue('transit')
  transit('Transit'),
  @JsonValue('received')
  received('Diterima');

  final String value;
  const SaleStockStatus(this.value);

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
