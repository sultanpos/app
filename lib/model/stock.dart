import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/branch.dart';
import 'package:sultanpos/model/product.dart';

part 'stock.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StockModel extends LocalSqlBase {
  final int id;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int stock;
  final int productId;
  final int branchId;
  final BranchModel? branch;
  final ProductModel? product;
  StockModel(
      this.id, this.updatedAt, this.deletedAt, this.stock, this.productId, this.branchId, this.branch, this.product);

  @override
  String? path() {
    return "/stock";
  }

  @override
  factory StockModel.fromJson(Map<String, dynamic> json) => _$StockModelFromJson(json);

  @override
  factory StockModel.fromSqlite(Map<String, dynamic> json) => _$StockModelFromJson(json);

  factory StockModel.empty() => StockModel(0, DateTime.now(), null, 0, 0, 0, null, null);

  @override
  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "stock";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() {
    final json = _$StockModelToJson(this);
    json.remove('branch');
    json.remove('product');
    return json;
  }

  @override
  bool syncUseBranch() {
    return true;
  }
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
