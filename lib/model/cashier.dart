import 'package:sultanpos/model/base.dart';

part 'cashier.g.dart';

@JsonSerializable(explicitToJson: true)
class CashierSessionModel extends BaseModel {
  final int id;
  final String number;
  @JsonKey(name: 'date_open')
  final DateTime dateOpen;
  @JsonKey(name: 'date_close')
  final DateTime? dateClose;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'open_value')
  final int openValue;
  @JsonKey(name: 'close_value')
  final int closeValue;
  @JsonKey(name: 'calculatedValue')
  final int calculatedValue;
  @JsonKey(name: 'machine_id')
  final int machineId;
  final String note;
  CashierSessionModel(
    this.id,
    this.number,
    this.dateOpen,
    this.dateClose,
    this.userId,
    this.openValue,
    this.closeValue,
    this.calculatedValue,
    this.machineId,
    this.note,
  );
  @override
  factory CashierSessionModel.fromJson(Map<String, dynamic> json) => _$CashierSessionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CashierSessionInsertModel extends BaseModel {
  @JsonKey(name: 'branch_id')
  final int branchId;
  @JsonKey(name: 'date_open')
  final DateTime dateOpen;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'open_value')
  final int openValue;
  @JsonKey(name: 'machine_id')
  final int machineId;
  final String note;

  CashierSessionInsertModel(
    this.branchId,
    this.dateOpen,
    this.userId,
    this.openValue,
    this.machineId,
    this.note,
  );

  @override
  factory CashierSessionInsertModel.fromJson(Map<String, dynamic> json) => _$CashierSessionInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CashierSessionCloseModel extends BaseModel {
  @JsonKey(name: 'date_close')
  final DateTime dateClose;
  @JsonKey(name: 'close_value')
  final int closeValue;
  @JsonKey(name: 'calculated_value')
  final int calculatedValue;

  CashierSessionCloseModel(
    this.dateClose,
    this.closeValue,
    this.calculatedValue,
  );

  @override
  factory CashierSessionCloseModel.fromJson(Map<String, dynamic> json) => _$CashierSessionCloseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CashierSessionCloseModelToJson(this);
}
