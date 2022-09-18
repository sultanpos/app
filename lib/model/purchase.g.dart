// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) =>
    PurchaseModel(
      json['public_id'] as String,
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['payment_paid'] as int,
      json['payment_residual'] as int,
      json['total'] as int,
      BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseModelToJson(PurchaseModel instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'subtotal': instance.subTotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'payment_paid': instance.paymentPaid,
      'payment_residual': instance.paymentResidual,
      'total': instance.total,
      'branch': instance.branch.toJson(),
      'partner': instance.partner.toJson(),
    };

PurchaseInsertModel _$PurchaseInsertModelFromJson(Map<String, dynamic> json) =>
    PurchaseInsertModel(
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['branch_public_id'] as String,
      json['partner_public_id'] as String,
      json['user_public_id'] as String,
      json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$PurchaseInsertModelToJson(
        PurchaseInsertModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'branch_public_id': instance.branchPublicId,
      'partner_public_id': instance.partnerPublicId,
      'user_public_id': instance.userPublicId,
      'deadline': instance.deadline?.toIso8601String(),
    };
