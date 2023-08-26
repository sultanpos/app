import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/product.dart';

part 'stock.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

@JsonSerializable(fieldRename: FieldRename.snake)
class SerialStockModel extends BaseModel {
  final int id;
  final BranchModel branch;
  final ProductModel? product;
  final String serialNumber;
  final int buyPrice;
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
