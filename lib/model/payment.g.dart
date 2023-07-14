// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      json['id'] as int,
      DateTime.parse(json['date'] as String),
      json['number'] as String,
      json['ref_number'] as String,
      json['user_id'] as int,
      $enumDecode(_$PaymentTypeEnumMap, json['type']),
      $enumDecode(_$PaymentReferEnumMap, json['refer']),
      json['amount'] as int,
      json['payment'] as int,
      json['note'] as String,
      json['cashier_session_id'] as int,
      PaymentMethodModel.fromJson(
          json['payment_method'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'number': instance.number,
      'ref_number': instance.refNumber,
      'user_id': instance.userId,
      'type': _$PaymentTypeEnumMap[instance.type]!,
      'refer': _$PaymentReferEnumMap[instance.refer]!,
      'amount': instance.amount,
      'payment': instance.payment,
      'note': instance.note,
      'cashier_session_id': instance.cashierSessionId,
      'payment_method': instance.paymentMethod,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.typeIn: 'in',
  PaymentType.typeOut: 'out',
};

const _$PaymentReferEnumMap = {
  PaymentRefer.purchase: 'purchase',
  PaymentRefer.sale: 'sale',
  PaymentRefer.other: 'other',
};
