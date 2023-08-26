import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';

part 'buyprice.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BuyPriceModel extends BaseModel {
  final int id;
  final int buyPrice;
  final int lastBuyPrice;
  final BranchModel branch;
  BuyPriceModel(this.id, this.buyPrice, this.lastBuyPrice, this.branch);

  @override
  factory BuyPriceModel.fromJson(Map<String, dynamic> json) => _$BuyPriceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuyPriceModelToJson(this);

  @override
  String? path() {
    return "/buyprice";
  }

  @override
  int getId() => id;
}
