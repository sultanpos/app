// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) =>
    PurchaseModel(
      json['id'] as int,
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['payment_paid'] as int,
      json['payment_residual'] as int,
      json['total'] as int,
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
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'subtotal': instance.subTotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'payment_paid': instance.paymentPaid,
      'payment_residual': instance.paymentResidual,
      'total': instance.total,
      'branch': instance.branch?.toJson(),
      'partner': instance.partner?.toJson(),
      'purchaseItems': instance.purchaseItems?.map((e) => e.toJson()).toList(),
    };

PurchaseInsertModel _$PurchaseInsertModelFromJson(Map<String, dynamic> json) =>
    PurchaseInsertModel(
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['branch_id'] as int,
      json['partner_id'] as int,
      json['user_id'] as int,
      json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      (json['purchase_items'] as List<dynamic>?)
          ?.map((e) => PurchaseItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseInsertModelToJson(
        PurchaseInsertModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'branch_id': instance.branchId,
      'partner_id': instance.partnerId,
      'user_id': instance.userId,
      'deadline': instance.deadline?.toIso8601String(),
      'purchase_items': instance.purchaseItems,
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
