import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/pricegroup.dart';

part 'price.g.dart';

@JsonSerializable()
class PriceModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  @JsonKey(name: 'price_group_public_id')
  final String priceGroupPublicId;
  final int count0;
  final int price0;
  @JsonKey(name: 'discount_formula0')
  final String discountFormula0;
  final int discount0;
  final int count1;
  final int price1;
  @JsonKey(name: 'discount_formula1')
  final String discountFormula1;
  final int discount1;
  final int count2;
  final int price2;
  @JsonKey(name: 'discount_formula2')
  final String discountFormula2;
  final int discount2;
  final int count3;
  final int price3;
  @JsonKey(name: 'discount_formula3')
  final String discountFormula3;
  final int discount3;
  final int count4;
  final int price4;
  @JsonKey(name: 'discount_formula4')
  final String discountFormula4;
  final int discount4;
  @JsonKey(name: 'price_group')
  final PriceGroupModel priceGroup;
  PriceModel(
    this.publicId,
    this.priceGroupPublicId,
    this.count0,
    this.price0,
    this.discountFormula0,
    this.discount0,
    this.count1,
    this.price1,
    this.discountFormula1,
    this.discount1,
    this.count2,
    this.price2,
    this.discountFormula2,
    this.discount2,
    this.count3,
    this.price3,
    this.discountFormula3,
    this.discount3,
    this.count4,
    this.price4,
    this.discountFormula4,
    this.discount4,
    this.priceGroup,
  );

  @override
  factory PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  @override
  String? path() {
    return "/price";
  }

  @override
  String getPublicId() => publicId;
}
