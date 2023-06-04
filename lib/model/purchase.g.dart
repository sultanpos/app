// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) =>
    PurchaseModel(
      json['id'] as int,
      DateTime.parse(json['date'] as String),
      json['ref_number'] as String,
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['stock_status'] as String,
      json['cashier_session_id'] as int,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['payment_paid'] as int,
      json['payment_residual'] as int,
      json['total'] as int,
      DateTime.parse(json['deadline'] as String),
      json['version'] as int,
      json['partner_id'] as int,
      json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      json['partner'] == null
          ? null
          : PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
      (json['purchaseItems'] as List<dynamic>?)
          ?.map((e) => PurchaseItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseModelToJson(PurchaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'ref_number': instance.refNumber,
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'stock_status': instance.stockStatus,
      'cashier_session_id': instance.cashierSessionId,
      'subtotal': instance.subTotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'payment_paid': instance.paymentPaid,
      'payment_residual': instance.paymentResidual,
      'total': instance.total,
      'deadline': instance.deadline.toIso8601String(),
      'version': instance.version,
      'partner_id': instance.partnerId,
      'branch': instance.branch?.toJson(),
      'partner': instance.partner?.toJson(),
      'purchaseItems': instance.purchaseItems?.map((e) => e.toJson()).toList(),
    };

PurchaseInsertModel _$PurchaseInsertModelFromJson(Map<String, dynamic> json) =>
    PurchaseInsertModel(
      DateTime.parse(json['date'] as String),
      json['branch_id'] as int,
      json['partner_id'] as int,
      json['ref_number'] as String,
      json['type'] as String,
      DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$PurchaseInsertModelToJson(
        PurchaseInsertModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'branch_id': instance.branchId,
      'partner_id': instance.partnerId,
      'ref_number': instance.refNumber,
      'type': instance.type,
      'deadline': instance.deadline.toIso8601String(),
    };

PurchaseUpdateModel _$PurchaseUpdateModelFromJson(Map<String, dynamic> json) =>
    PurchaseUpdateModel(
      DateTime.parse(json['date'] as String),
      json['branch_id'] as int,
      json['partner_id'] as int,
      json['ref_number'] as String,
      DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$PurchaseUpdateModelToJson(
        PurchaseUpdateModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'branch_id': instance.branchId,
      'partner_id': instance.partnerId,
      'ref_number': instance.refNumber,
      'deadline': instance.deadline.toIso8601String(),
    };

PurchaseItemModel _$PurchaseItemModelFromJson(Map<String, dynamic> json) =>
    PurchaseItemModel(
      json['public_id'] as String,
      ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      json['amount'] as int,
      json['buy_price'] as int,
      json['price'] as int,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['total'] as int,
      json['note'] as String,
      json['serial_stock'] == null
          ? null
          : SerialStockModel.fromJson(
              json['serial_stock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseItemModelToJson(PurchaseItemModel instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'product': instance.product,
      'amount': instance.amount,
      'buy_price': instance.buyPrice,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'total': instance.total,
      'note': instance.note,
      'serial_stock': instance.serialStock,
    };
