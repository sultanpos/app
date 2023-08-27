import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/product.dart';
import 'package:sultanpos/model/request.dart';
import 'package:sultanpos/model/user.dart';

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
    return index - other.index;
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
    return index - other.index;
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
    return index - other.index;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SaleModel extends LocalSqlBase {
  final int id;
  final String number;
  final DateTime date;
  final int branchId;
  final int userId;
  final String refNumber;
  final SaleType type;
  final SaleStatus status;
  final SaleStockStatus stockStatus;
  final int cashierSessionId;
  final int subtotal;
  final String discountFormula;
  final int discount;
  final int paymentPaid;
  final int paymentResidual;
  final int total;
  final DateTime? deadline;
  final int version;
  final int partnerId;
  final PartnerModel? partner;
  final DateTime? syncAt;
  final UserModel? user;
  SaleModel(
    this.id,
    this.number,
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
    this.user,
    this.syncAt,
  );

  @override
  factory SaleModel.fromJson(Map<String, dynamic> json) => _$SaleModelFromJson(json);

  @override
  factory SaleModel.fromSqlite(Map<String, dynamic> json) {
    final res = Map<String, dynamic>.from(json);
    res['version'] = 0;
    return _$SaleModelFromJson(res);
  }

  factory SaleModel.empty() => SaleModel(0, '', DateTime.now(), 1, 0, '', SaleType.normal, SaleStatus.draft,
      SaleStockStatus.none, 0, 0, '', 0, 0, 0, 0, null, 0, 0, null, null, null);

  @override
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "sale";
  }

  @override
  DateTime getUpdatedAt() {
    return DateTime.now();
  }

  @override
  Map<String, dynamic> toSqlite() {
    final obj = _$SaleModelToJson(this);
    if (id == 0) obj['id'] = null;
    obj.remove('user');
    obj.remove('partner');
    obj.remove('version');
    return obj;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SaleItemModel extends LocalSqlBase {
  final int id;
  final int saleId;
  final int productId;
  final int batch;
  final int amount;
  final int buyPrice;
  final int price;
  final int subtotal;
  final String discountFormula;
  final int discount;
  final int total;
  final String note;
  final ProductModel? product;

  SaleItemModel(this.id, this.saleId, this.productId, this.batch, this.amount, this.buyPrice, this.price, this.subtotal,
      this.discountFormula, this.discount, this.total, this.note, this.product);

  @override
  factory SaleItemModel.fromJson(Map<String, dynamic> json) => _$SaleItemModelFromJson(json);

  @override
  factory SaleItemModel.fromSqlite(Map<String, dynamic> json) => _$SaleItemModelFromJson(json);

  factory SaleItemModel.empty() => SaleItemModel(0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, '', null);

  @override
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "saleitem";
  }

  @override
  DateTime getUpdatedAt() {
    return DateTime.now();
  }

  @override
  Map<String, dynamic> toSqlite() {
    final obj = _$SaleItemModelToJson(this);
    if (id == 0) obj['id'] = null;
    obj.remove('product');
    return obj;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaymentCashierInsertModel extends BaseModel {
  final int amount;
  final int payment;
  final int changes;
  final int paymentMethodId;
  final String reference;
  final String note;

  PaymentCashierInsertModel({
    required this.amount,
    required this.payment,
    required this.changes,
    required this.paymentMethodId,
    required this.reference,
    required this.note,
  });

  @override
  factory PaymentCashierInsertModel.fromJson(Map<String, dynamic> json) => _$PaymentCashierInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentCashierInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SaleItemInsertModel extends BaseModel {
  final int batch;
  final int productId;
  final int amount;
  final int price;
  final int subtotal;
  final String discountFormula;
  final int discount;
  final int total;
  final String note;

  SaleItemInsertModel({
    required this.batch,
    required this.productId,
    required this.amount,
    required this.price,
    required this.subtotal,
    required this.discountFormula,
    required this.discount,
    required this.total,
    required this.note,
  });

  @override
  factory SaleItemInsertModel.fromJson(Map<String, dynamic> json) => _$SaleItemInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleItemInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SaleCashierInsertModel extends BaseModel {
  final int branchId;
  final int version;
  final String number;
  final int userId;
  final int cashierSessionId;
  final DateTime date;
  final int partnerId;
  final DateTime? deadline;
  final String discountFormula;
  final int subtotal;
  final int discount;
  final int total;
  final List<SaleItemInsertModel> items;
  final List<PaymentCashierInsertModel> payments;

  SaleCashierInsertModel({
    required this.branchId,
    required this.version,
    required this.number,
    required this.userId,
    required this.cashierSessionId,
    required this.date,
    required this.partnerId,
    required this.deadline,
    required this.discountFormula,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.items,
    required this.payments,
  });

  @override
  factory SaleCashierInsertModel.fromJson(Map<String, dynamic> json) => _$SaleCashierInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleCashierInsertModelToJson(this);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => InsertSuccessModel.fromJson(json);
}
