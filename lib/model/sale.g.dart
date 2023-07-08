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

SaleItemModel _$SaleItemModelFromJson(Map<String, dynamic> json) =>
    SaleItemModel(
      json['id'] as int,
      json['sale_id'] as int,
      json['product_id'] as int,
      json['batch'] as int,
      json['amount'] as int,
      json['buy_price'] as int,
      json['price'] as int,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['total'] as int,
      json['note'] as String,
    );

Map<String, dynamic> _$SaleItemModelToJson(SaleItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sale_id': instance.saleId,
      'product_id': instance.productId,
      'batch': instance.batch,
      'amount': instance.amount,
      'buy_price': instance.buyPrice,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'total': instance.total,
      'note': instance.note,
    };

PaymentCashierInsertModel _$PaymentCashierInsertModelFromJson(
        Map<String, dynamic> json) =>
    PaymentCashierInsertModel(
      amount: json['amount'] as int,
      payment: json['payment'] as int,
      changes: json['changes'] as int,
      paymentMethodID: json['payment_method_id'] as int,
      reference: json['reference'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$PaymentCashierInsertModelToJson(
        PaymentCashierInsertModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'payment': instance.payment,
      'changes': instance.changes,
      'payment_method_id': instance.paymentMethodID,
      'reference': instance.reference,
      'note': instance.note,
    };

SaleItemInsertModel _$SaleItemInsertModelFromJson(Map<String, dynamic> json) =>
    SaleItemInsertModel(
      batch: json['batch'] as int,
      productId: json['product_id'] as int,
      amount: json['amount'] as int,
      price: json['price'] as int,
      subtotal: json['subtotal'] as int,
      discountFormula: json['discount_formula'] as String,
      discount: json['discount'] as int,
      total: json['total'] as int,
      note: json['note'] as String,
    );

Map<String, dynamic> _$SaleItemInsertModelToJson(
        SaleItemInsertModel instance) =>
    <String, dynamic>{
      'batch': instance.batch,
      'product_id': instance.productId,
      'amount': instance.amount,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'total': instance.total,
      'note': instance.note,
    };

SaleCashierInsertModel _$SaleCashierInsertModelFromJson(
        Map<String, dynamic> json) =>
    SaleCashierInsertModel(
      version: json['version'] as int,
      number: json['number'] as String,
      userId: json['user_id'] as int,
      cashierSessionId: json['cashier_session_id'] as int,
      date: DateTime.parse(json['date'] as String),
      partnerId: json['partner_id'] as int,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      discountFormula: json['discount_formula'] as String,
      subtotal: json['subtotal'] as int,
      discount: json['discount'] as int,
      total: json['total'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => SaleItemInsertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      payments: (json['payments'] as List<dynamic>)
          .map((e) =>
              PaymentCashierInsertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleCashierInsertModelToJson(
        SaleCashierInsertModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'number': instance.number,
      'user_id': instance.userId,
      'cashier_session_id': instance.cashierSessionId,
      'date': instance.date.toIso8601String(),
      'partner_id': instance.partnerId,
      'deadline': instance.deadline?.toIso8601String(),
      'discount_formula': instance.discountFormula,
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'total': instance.total,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };
