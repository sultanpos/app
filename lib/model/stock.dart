import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';

part 'stock.g.dart';

@JsonSerializable()
class StockModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final int stock;
  final BranchModel branch;
  StockModel(this.publicId, this.stock, this.branch);

  @override
  String? path() {
    return "/stock";
  }

  @override
  factory StockModel.fromJson(Map<String, dynamic> json) => _$StockModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  @override
  String getPublicId() => publicId;
}
