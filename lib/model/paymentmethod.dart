import 'package:sultanpos/model/base.dart';

part 'paymentmethod.g.dart';

enum PaymentMethodType implements Comparable<PaymentMethodType> {
  @JsonValue('cash')
  cash('cash', 'Cash'),
  @JsonValue('edc')
  edc('edc', 'EDC'),
  @JsonValue('transfer')
  transfer('transfer', 'Transfer'),
  @JsonValue('online')
  online('online', 'Online');

  final String value;
  final String text;
  const PaymentMethodType(this.value, this.text);

  @override
  int compareTo(PaymentMethodType other) {
    return index - other.index;
  }
}

@JsonSerializable()
class PaymentMethodModel extends BaseModel {
  final int id;
  @JsonKey(name: 'branch_id')
  final int branchId;
  final String name;
  final String description;
  final int additional;
  final PaymentMethodType method;
  @JsonKey(name: 'is_default')
  final bool isDefault;
  PaymentMethodModel(this.id, this.branchId, this.name, this.description, this.additional, this.method, this.isDefault);

  @override
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  @override
  int getId() => id;
}

@JsonSerializable()
class PaymentMethodInsertModel extends BaseModel {
  @JsonKey(name: 'branch_id')
  final int branchId;
  final String name;
  final String description;
  final int additional;
  final PaymentMethodType method;
  PaymentMethodInsertModel(this.branchId, this.name, this.description, this.additional, this.method);

  @override
  factory PaymentMethodInsertModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentMethodInsertModelToJson(this);
}

@JsonSerializable()
class PaymentMethodUpdateModel extends BaseModel {
  @JsonKey(name: 'branch_id')
  final int branchId;
  final String name;
  final String description;
  final int additional;
  final PaymentMethodType method;
  PaymentMethodUpdateModel(this.branchId, this.name, this.description, this.additional, this.method);

  @override
  factory PaymentMethodUpdateModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodUpdateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentMethodUpdateModelToJson(this);
}
