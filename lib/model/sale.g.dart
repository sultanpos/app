// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) => SaleModel(
      json['id'] as int,
      DateTime.parse(json['date'] as String),
      json['branch_id'] as int,
      json['user_id'] as int,
      json['ref_number'] as String,
      $enumDecode(_$SaleTypeEnumMap, json['type']),
      $enumDecode(_$SaleStatusEnumMap, json['status']),
      $enumDecode(_$SaleStockStatusEnumMap, json['stock_status']),
      json['cashier_session_id'] as int,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['payment_paid'] as int,
      json['payment_residual'] as int,
      json['total'] as int,
      json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      json['version'] as int,
      json['partner_id'] as int,
      json['partner'] == null
          ? null
          : PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleModelToJson(SaleModel instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'branch_id': instance.branchId,
      'user_id': instance.userId,
      'ref_number': instance.refNumber,
      'type': _$SaleTypeEnumMap[instance.type]!,
      'status': _$SaleStatusEnumMap[instance.status]!,
      'stock_status': _$SaleStockStatusEnumMap[instance.stockStatus]!,
      'cashier_session_id': instance.cashierSessionId,
      'subtotal': instance.subtotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'payment_paid': instance.paymentPaid,
      'payment_residual': instance.paymentResidual,
      'total': instance.total,
      'deadline': instance.deadline?.toIso8601String(),
      'version': instance.version,
      'partner_id': instance.partnerId,
      'partner': instance.partner?.toJson(),
    };

const _$SaleTypeEnumMap = {
  SaleType.so: 'so',
  SaleType.normal: 'normal',
  SaleType.cashier: 'cashier',
};

const _$SaleStatusEnumMap = {
  SaleStatus.draft: 'draft',
  SaleStatus.validated: 'validated',
  SaleStatus.inProgress: 'in_progress',
  SaleStatus.done: 'done',
};

const _$SaleStockStatusEnumMap = {
  SaleStockStatus.none: 'none',
  SaleStockStatus.transit: 'transit',
  SaleStockStatus.received: 'received',
};
