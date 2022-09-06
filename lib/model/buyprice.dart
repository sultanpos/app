import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';

part 'buyprice.g.dart';

@JsonSerializable()
class BuyPriceModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  @JsonKey(name: 'last_buy_price')
  final int lastBuyPrice;
  final BranchModel branch;
  BuyPriceModel(this.publicId, this.buyPrice, this.lastBuyPrice, this.branch);

  @override
  factory BuyPriceModel.fromJson(Map<String, dynamic> json) => _$BuyPriceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuyPriceModelToJson(this);

  @override
  String? path() {
    return "/buyprice";
  }

  @override
  String getPublicId() => publicId;
}
