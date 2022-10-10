import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/product.dart';

part 'stock.g.dart';

@JsonSerializable()
class StockModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final int stock;
  final BranchModel branch;
  final ProductModel? product;
  StockModel(this.publicId, this.stock, this.branch, this.product);

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

@JsonSerializable()
class SerialStockModel extends BaseModel {
  @JsonKey(name: 'public_id')
  final String publicId;
  final BranchModel branch;
  final ProductModel? product;
  @JsonKey(name: 'serial_number')
  final String serialNumber;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  @JsonKey(name: 'sell_price')
  final int sellPrice;
  final String status;

  SerialStockModel(this.publicId, this.branch, this.product, this.serialNumber, this.buyPrice, this.sellPrice, this.status);

  @override
  String? path() {
    return "/stock";
  }

  @override
  factory SerialStockModel.fromJson(Map<String, dynamic> json) => _$SerialStockModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SerialStockModelToJson(this);

  @override
  String getPublicId() => publicId;
}
