// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashierSessionModel _$CashierSessionModelFromJson(Map<String, dynamic> json) =>
    CashierSessionModel(
      json['id'] as int,
      json['number'] as String,
      DateTime.parse(json['date_open'] as String),
      json['date_close'] == null
          ? null
          : DateTime.parse(json['date_close'] as String),
      json['user_id'] as int,
      json['open_value'] as int,
      json['close_value'] as int,
      json['calculatedValue'] as int,
      json['machine_id'] as int,
      json['note'] as String,
    );

Map<String, dynamic> _$CashierSessionModelToJson(
        CashierSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'date_open': instance.dateOpen.toIso8601String(),
      'date_close': instance.dateClose?.toIso8601String(),
      'user_id': instance.userId,
      'open_value': instance.openValue,
      'close_value': instance.closeValue,
      'calculatedValue': instance.calculatedValue,
      'machine_id': instance.machineId,
      'note': instance.note,
    };

CashierSessionInsertModel _$CashierSessionInsertModelFromJson(
        Map<String, dynamic> json) =>
    CashierSessionInsertModel(
      json['branch_id'] as int,
      DateTime.parse(json['date_open'] as String),
      json['user_id'] as int,
      json['open_value'] as int,
      json['machine_id'] as int,
      json['note'] as String,
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
      json['calculated_value'] as int,
    );

Map<String, dynamic> _$CashierSessionCloseModelToJson(
        CashierSessionCloseModel instance) =>
    <String, dynamic>{
      'date_close': instance.dateClose.toIso8601String(),
      'close_value': instance.closeValue,
      'calculated_value': instance.calculatedValue,
    };
