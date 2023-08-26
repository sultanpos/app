import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/buyprice.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/price.dart';
import 'package:sultanpos/model/stock.dart';
import 'package:sultanpos/model/unit.dart';

part 'product.g.dart';

enum ProductType implements Comparable<ProductType> {
  @JsonValue('template')
  template('template', 'Template'),
  @JsonValue('product')
  product('product', 'Produk'),
  @JsonValue('service')
  service('service', 'Jasa'),
  @JsonValue('package')
  package('package', 'Paket');

  final String value;
  final String text;
  const ProductType(this.value, this.text);

  @override
  int compareTo(ProductType other) {
    return index - other.index;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductModel extends LocalSqlBase {
  final int id;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int parentId;
  final String barcode;
  final String name;
  final String description;
  final bool allBranch;
  final String mainImage;
  final bool calculateStock;
  final ProductType productType;
  final bool sellable;
  final bool buyable;
  final bool editablePrice;
  final bool useSn;
  final bool serial;
  final int unitId;
  final UnitModel? unit;
  final CategoryModel? category;
  final PartnerModel? partner;
  final List<PriceModel>? prices;
  final List<BuyPriceModel>? buyPrices;
  final List<StockModel>? stocks;

  ProductModel(
    this.id,
    this.updatedAt,
    this.deletedAt,
    this.parentId,
    this.barcode,
    this.name,
    this.description,
    this.allBranch,
    this.mainImage,
    this.calculateStock,
    this.productType,
    this.sellable,
    this.buyable,
    this.editablePrice,
    this.useSn,
    this.serial,
    this.unitId,
    this.unit,
    this.category,
    this.partner,
    this.prices,
    this.buyPrices,
    this.stocks,
  );

  @override
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.empty() => ProductModel(0, DateTime.now(), null, 0, '', '', '', true, '', true,
      ProductType.product, true, true, true, false, false, 0, null, null, null, null, null, null);

  @override
  String? path() => '/product';

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  int getId() => id;

  int priceForAmount(int amount) {
    if (prices?.isEmpty ?? true) {
      return 0;
    }
    //TODO: find the proper index from list of prices
    const idx = 0;
    final price = prices![idx];
    if (price.count4 > 0 && price.count4 <= amount) {
      return price.price4;
    } else if (price.count3 > 0 && price.count3 <= amount) {
      return price.price3;
    }
    if (price.count2 > 0 && price.count2 <= amount) {
      return price.price2;
    }
    if (price.count1 > 0 && price.count1 <= amount) {
      return price.price1;
    }
    return price.price0;
  }

  List<(int, int)> priceList() {
    List<(int, int)> retVal = [];
    if (prices?.isEmpty ?? true) {
      return retVal;
    }
    //TODO: find the proper index from list of prices
    const idx = 0;
    final price = prices![idx];
    if (price.price0 == 0) return retVal;
    retVal.add((price.count0, price.price0));
    if (price.price1 == 0) return retVal;
    retVal.add((price.count1, price.price1));
    if (price.price2 == 0) return retVal;
    retVal.add((price.count2, price.price2));
    if (price.price3 == 0) return retVal;
    retVal.add((price.count3, price.price3));
    if (price.price4 == 0) return retVal;
    retVal.add((price.count4, price.price4));
    return retVal;
  }

  @override
  String getTableName() {
    return "product";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() {
    final ret = _$ProductModelToJson(this);
    ret["all_branch"] = allBranch ? 1 : 0;
    ret["calculate_stock"] = calculateStock ? 1 : 0;
    ret["sellable"] = sellable ? 1 : 0;
    ret["buyable"] = buyable ? 1 : 0;
    ret["editable_price"] = editablePrice ? 1 : 0;
    ret["use_sn"] = useSn ? 1 : 0;
    ret["serial"] = serial ? 1 : 0;
    ret.remove('unit');
    ret.remove('category');
    ret.remove('partner');
    ret.remove('buy_prices');
    ret.remove('stocks');
    ret.remove('prices');
    return ret;
  }

  @override
  factory ProductModel.fromSqlite(Map<String, dynamic> json) {
    final newJson = Map<String, dynamic>.from(json);
    newJson["all_branch"] = json["all_branch"] != 0;
    newJson["calculate_stock"] = json["calculate_stock"] != 0;
    newJson["sellable"] = json["sellable"] != 0;
    newJson["buyable"] = json["buyable"] != 0;
    newJson["editable_price"] = json["editable_price"] != 0;
    newJson["use_sn"] = json["use_sn"] != 0;
    newJson["serial"] = json["serial"] != 0;
    return _$ProductModelFromJson(newJson);
  }

  copyWith({
    UnitModel? unit,
    CategoryModel? category,
    PartnerModel? partner,
    List<PriceModel>? prices,
  }) {
    return ProductModel(
      id,
      updatedAt,
      deletedAt,
      parentId,
      barcode,
      name,
      description,
      allBranch,
      mainImage,
      calculateStock,
      productType,
      sellable,
      buyable,
      editablePrice,
      useSn,
      serial,
      unitId,
      unit ?? this.unit,
      category ?? this.category,
      partner ?? this.partner,
      prices ?? this.prices,
      buyPrices,
      stocks,
    );
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductInsertModel extends BaseModel {
  final String barcode;
  final String name;
  final String description;
  final bool allBranch;
  final String mainImage;
  final bool calculateStock;
  final String productType;
  final int unitId;
  final int categoryId;
  final int partnerId;
  final List<String> branches;
  final int buyPrice;
  final bool sellable;
  final bool buyable;
  final bool editablePrice;
  final bool useSn;
  final List<ProductStockInsertModel> stocks;
  final ProductPriceInsertModel price;

  ProductInsertModel(
      this.barcode,
      this.name,
      this.description,
      this.allBranch,
      this.mainImage,
      this.calculateStock,
      this.productType,
      this.sellable,
      this.buyable,
      this.editablePrice,
      this.useSn,
      this.unitId,
      this.partnerId,
      this.categoryId,
      this.branches,
      this.buyPrice,
      this.stocks,
      this.price);

  @override
  factory ProductInsertModel.fromJson(Map<String, dynamic> json) => _$ProductInsertModelFromJson(json);

  @override
  String? path() => '/product';

  @override
  Map<String, dynamic> toJson() => _$ProductInsertModelToJson(this);
}

@JsonSerializable()
class ProductStockInsertModel extends BaseModel {
  @JsonKey(name: 'branch_id')
  final int branchID;
  final int stock;

  ProductStockInsertModel(this.branchID, this.stock);

  @override
  factory ProductStockInsertModel.fromJson(Map<String, dynamic> json) => _$ProductStockInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductStockInsertModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductPriceInsertModel extends BaseModel {
  final int price0;
  final int count0;
  final String discountFormula0;
  final int discount0;
  final int price1;
  final int count1;
  final String discountFormula1;
  final int discount1;
  final int price2;
  final int count2;
  final String discountFormula2;
  final int discount2;
  final int price3;
  final int count3;
  final String discountFormula3;
  final int discount3;
  final int price4;
  final int count4;
  final String discountFormula4;
  final int discount4;

  ProductPriceInsertModel(
      this.price0,
      this.count0,
      this.discountFormula0,
      this.discount0,
      this.price1,
      this.count1,
      this.discountFormula1,
      this.discount1,
      this.price2,
      this.count2,
      this.discountFormula2,
      this.discount2,
      this.price3,
      this.count3,
      this.discountFormula3,
      this.discount3,
      this.price4,
      this.count4,
      this.discountFormula4,
      this.discount4);

  @override
  factory ProductPriceInsertModel.fromJson(Map<String, dynamic> json) => _$ProductPriceInsertModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductPriceInsertModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductUpdateModel extends BaseModel {
  final String barcode;
  final String name;
  final String description;
  final bool allBranch;
  final String mainImage;
  final bool calculateStock;
  final String productType;
  final int unitId;
  final int categoryId;
  final int partnerId;
  final bool sellable;
  final bool buyable;
  final bool editablePrice;
  final bool useSn;
  final ProductPriceInsertModel price;

  ProductUpdateModel(
    this.barcode,
    this.name,
    this.description,
    this.allBranch,
    this.mainImage,
    this.calculateStock,
    this.productType,
    this.unitId,
    this.partnerId,
    this.categoryId,
    this.sellable,
    this.buyable,
    this.editablePrice,
    this.useSn,
    this.price,
  );

  @override
  factory ProductUpdateModel.fromJson(Map<String, dynamic> json) => _$ProductUpdateModelFromJson(json);

  @override
  String? path() => '/product';

  @override
  Map<String, dynamic> toJson() => _$ProductUpdateModelToJson(this);
}
