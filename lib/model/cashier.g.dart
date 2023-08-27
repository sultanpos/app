// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashierSessionModel _$CashierSessionModelFromJson(Map<String, dynamic> json) =>
    CashierSessionModel(
      json['id'] as int,
      DateTime.parse(json['updated_at'] as String),
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['branch_id'] as int,
      json['number'] as String,
      DateTime.parse(json['date_open'] as String),
      json['date_close'] == null
          ? null
          : DateTime.parse(json['date_close'] as String),
      json['user_id'] as int,
      json['open_value'] as int,
      json['close_value'] as int,
      json['calculated_value'] as int,
      json['machine_id'] as int,
      json['note'] as String,
      json['sync_at'] == null
          ? null
          : DateTime.parse(json['sync_at'] as String),
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashierSessionModelToJson(
        CashierSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'branch_id': instance.branchId,
      'number': instance.number,
      'date_open': instance.dateOpen.toIso8601String(),
      'date_close': instance.dateClose?.toIso8601String(),
      'user_id': instance.userId,
      'open_value': instance.openValue,
      'close_value': instance.closeValue,
      'calculated_value': instance.calculatedValue,
      'machine_id': instance.machineId,
      'note': instance.note,
      'sync_at': instance.syncAt?.toIso8601String(),
      'user': instance.user?.toJson(),
    };

CashierSessionInsertModel _$CashierSessionInsertModelFromJson(
        Map<String, dynamic> json) =>
    CashierSessionInsertModel(
      branchId: json['branch_id'] as int,
      dateOpen: DateTime.parse(json['date_open'] as String),
      userId: json['user_id'] as int,
      openValue: json['open_value'] as int,
      machineId: json['machine_id'] as int,
      note: json['note'] as String,
    );

Map<String, dynamic> _$CashierSessionInsertModelToJson(
        CashierSessionInsertModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'date_open': instance.dateOpen.toIso8601String(),
      'user_id': instance.userId,
      'open_value': instance.openValue,
      'machine_id': instance.machineId,
      'note': instance.note,
    };

CashierSessionCloseModel _$CashierSessionCloseModelFromJson(
        Map<String, dynamic> json) =>
    CashierSessionCloseModel(
      DateTime.parse(json['date_close'] as String),
      json['close_value'] as int,
    );

Map<String, dynamic> _$CashierSessionCloseModelToJson(
        CashierSessionCloseModel instance) =>
    <String, dynamic>{
      'date_close': instance.dateClose.toIso8601String(),
      'close_value': instance.closeValue,
    };

CashierSessionReportModel _$CashierSessionReportModelFromJson(
        Map<String, dynamic> json) =>
    CashierSessionReportModel(
      json['sale_count'] as int,
      json['payment_in_count'] as int,
      json['payment_out_count'] as int,
      json['payment_in_total'] as int,
      json['payment_out_total'] as int,
    );

Map<String, dynamic> _$CashierSessionReportModelToJson(
        CashierSessionReportModel instance) =>
    <String, dynamic>{
      'sale_count': instance.saleCount,
      'payment_in_count': instance.paymentInCount,
      'payment_out_count': instance.paymentOutCount,
      'payment_in_total': instance.paymentInTotal,
      'payment_out_total': instance.paymentOutTotal,
    };
