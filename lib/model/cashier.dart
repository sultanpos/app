import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/user.dart';

part 'cashier.g.dart';

typedef JsonReadValueFn = Object? Function(Map, String)?;

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CashierSessionModel extends LocalSqlBase {
  final int id;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int branchId;
  final String number;
  final DateTime dateOpen;
  final DateTime? dateClose;
  final int userId;
  final int openValue;
  final int closeValue;
  final int calculatedValue;
  final int machineId;
  final String note;
  final DateTime? syncAt;
  final UserModel? user;
  CashierSessionModel(
    this.id,
    this.updatedAt,
    this.deletedAt,
    this.branchId,
    this.number,
    this.dateOpen,
    this.dateClose,
    this.userId,
    this.openValue,
    this.closeValue,
    this.calculatedValue,
    this.machineId,
    this.note,
    this.syncAt,
    this.user,
  );
  @override
  factory CashierSessionModel.fromJson(Map<String, dynamic> json) => _$CashierSessionModelFromJson(json);
  factory CashierSessionModel.empty() =>
      CashierSessionModel(0, DateTime.now(), null, 0, '', DateTime.now(), null, 0, 0, 0, 0, 0, '', null, null);

  @override
  factory CashierSessionModel.fromSqlite(Map<String, dynamic> json) => _$CashierSessionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionModelToJson(this);

  @override
  String getTableName() {
    return 'cashiersession';
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  int getId() => id;

  @override
  Map<String, dynamic> toSqlite() {
    final json = _$CashierSessionModelToJson(this);
    if (id == 0) json.remove('id');
    json.remove('user');
    return json;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CashierSessionInsertModel extends BaseModel {
  final int branchId;
  final DateTime dateOpen;
  final int userId;
  final int openValue;
  final int machineId;
  final String note;

  CashierSessionInsertModel({
    required this.branchId,
    required this.dateOpen,
    required this.userId,
    required this.openValue,
    required this.machineId,
    required this.note,
  });

  @override
  factory CashierSessionInsertModel.fromJson(Map<String, dynamic> json) => _$CashierSessionInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CashierSessionCloseModel extends BaseModel {
  final DateTime dateClose;
  final int closeValue;

  CashierSessionCloseModel(
    this.dateClose,
    this.closeValue,
  );

  @override
  factory CashierSessionCloseModel.fromJson(Map<String, dynamic> json) => _$CashierSessionCloseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionCloseModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CashierSessionReportModel extends BaseModel {
  final int saleCount;
  final int paymentInCount;
  final int paymentOutCount;
  final int paymentInTotal;
  final int paymentOutTotal;
  CashierSessionReportModel(
    this.saleCount,
    this.paymentInCount,
    this.paymentOutCount,
    this.paymentInTotal,
    this.paymentOutTotal,
  );

  @override
  factory CashierSessionReportModel.fromJson(Map<String, dynamic> json) => _$CashierSessionReportModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionReportModelToJson(this);

  int calculated() {
    return paymentInTotal - paymentOutTotal;
  }
}
