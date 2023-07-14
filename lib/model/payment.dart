import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/paymentmethod.dart';

part 'payment.g.dart';

enum PaymentType implements Comparable<PaymentType> {
  @JsonValue('in')
  typeIn('in', 'Income'),
  @JsonValue('out')
  typeOut('out', 'Expense');

  final String value;
  final String text;
  const PaymentType(this.value, this.text);

  @override
  int compareTo(PaymentType other) {
    return 0;
  }
}

enum PaymentRefer implements Comparable<PaymentRefer> {
  @JsonValue('purchase')
  purchase('purchase', 'Purchase'),
  @JsonValue('sale')
  sale('sale', 'Sales'),
  @JsonValue('other')
  other('other', 'Other');

  final String value;
  final String text;
  const PaymentRefer(this.value, this.text);

  @override
  int compareTo(PaymentRefer other) {
    return 0;
  }
}

@JsonSerializable()
class PaymentModel extends BaseModel {
  final int id;
  final DateTime date;
  final String number;
  @JsonKey(name: 'ref_number')
  final String refNumber;
  @JsonKey(name: 'user_id')
  final int userId;
  final PaymentType type;
  final PaymentRefer refer;
  final int amount;
  final int payment;
  final String note;
  @JsonKey(name: 'cashier_session_id')
  final int cashierSessionId;
  @JsonKey(name: 'payment_method')
  final PaymentMethodModel paymentMethod;

  PaymentModel(
    this.id,
    this.date,
    this.number,
    this.refNumber,
    this.userId,
    this.type,
    this.refer,
    this.amount,
    this.payment,
    this.note,
    this.cashierSessionId,
    this.paymentMethod,
  );

  @override
  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  @override
  int getId() => id;
}
