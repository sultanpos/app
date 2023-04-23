import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/product.dart';

part 'stock.g.dart';

@JsonSerializable()
class StockModel extends BaseModel {
  final int id;
  final int stock;
  final BranchModel branch;
  final ProductModel? product;
  StockModel(this.id, this.stock, this.branch, this.product);

  @override
  String? path() {
    return "/stock";
  }

  @override
  factory StockModel.fromJson(Map<String, dynamic> json) => _$StockModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  @override
  int getId() => id;
}

@JsonSerializable()
class SerialStockModel extends BaseModel {
  final int id;
  final BranchModel branch;
  final ProductModel? product;
  @JsonKey(name: 'serial_number')
  final String serialNumber;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  @JsonKey(name: 'sell_price')
  final int sellPrice;
  final String status;

  SerialStockModel(this.id, this.branch, this.product, this.serialNumber, this.buyPrice, this.sellPrice, this.status);

  @override
  String? path() {
    return "/stock";
  }

  @override
  factory SerialStockModel.fromJson(Map<String, dynamic> json) => _$SerialStockModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SerialStockModelToJson(this);

  @override
  int getId() => id;
}
