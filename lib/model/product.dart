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
    return 0;
  }
}

@JsonSerializable(explicitToJson: true)
class ProductModel extends BaseModel {
  final int id;
  @JsonKey(name: 'parent_id')
  final int parentId;
  final String barcode;
  final String name;
  final String description;
  @JsonKey(name: 'all_branch')
  final bool allBranch;
  @JsonKey(name: 'main_image')
  final String mainImage;
  @JsonKey(name: 'calculate_stock')
  final bool calculateStock;
  @JsonKey(name: 'product_type')
  final ProductType productType;
  final bool sellable;
  final bool buyable;
  @JsonKey(name: 'editable_price')
  final bool editablePrice;
  @JsonKey(name: 'use_sn')
  final bool useSn;
  final UnitModel? unit;
  final CategoryModel? category;
  final PartnerModel? partner;
  final List<PriceModel>? prices;
  @JsonKey(name: 'buy_prices')
  final List<BuyPriceModel>? buyPrices;
  final List<StockModel>? stocks;

  ProductModel(
    this.id,
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
    this.unit,
    this.category,
    this.partner,
    this.prices,
    this.buyPrices,
    this.stocks,
  );

  @override
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

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
    for (var i = 0; i < prices!.length; i++) {
      if (prices![i].count0 >= amount) {
        return prices![i].price0;
      } else if (prices![i].count1 >= amount) {
        return prices![i].price1;
      }
      if (prices![i].count2 >= amount) {
        return prices![i].price2;
      }
      if (prices![i].count3 >= amount) {
        return prices![i].price3;
      }
      if (prices![i].count4 >= amount) {
        return prices![i].price4;
      }
    }
    return 0;
  }
}

@JsonSerializable(explicitToJson: true)
class ProductInsertModel extends BaseModel {
  final String barcode;
  final String name;
  final String description;
  @JsonKey(name: 'all_branch')
  final bool allBranch;
  @JsonKey(name: 'main_image')
  final String mainImage;
  @JsonKey(name: 'calculate_stock')
  final bool calculateStock;
  @JsonKey(name: 'product_type')
  final String productType;
  @JsonKey(name: 'unit_id')
  final int unitId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final List<String> branches;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  final bool sellable;
  final bool buyable;
  @JsonKey(name: 'editable_price')
  final bool editablePrice;
  @JsonKey(name: 'use_sn')
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

@JsonSerializable()
class ProductPriceInsertModel extends BaseModel {
  final int price0;
  final int count0;
  @JsonKey(name: 'discount_formula0')
  final String discountFormula0;
  final int discount0;
  final int price1;
  final int count1;
  @JsonKey(name: 'discount_formula1')
  final String discountFormula1;
  final int discount1;
  final int price2;
  final int count2;
  @JsonKey(name: 'discount_formula2')
  final String discountFormula2;
  final int discount2;
  final int price3;
  final int count3;
  @JsonKey(name: 'discount_formula3')
  final String discountFormula3;
  final int discount3;
  final int price4;
  final int count4;
  @JsonKey(name: 'discount_formula4')
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

@JsonSerializable(explicitToJson: true)
class ProductUpdateModel extends BaseModel {
  final String barcode;
  final String name;
  final String description;
  @JsonKey(name: 'all_branch')
  final bool allBranch;
  @JsonKey(name: 'main_image')
  final String mainImage;
  @JsonKey(name: 'calculate_stock')
  final bool calculateStock;
  @JsonKey(name: 'product_type')
  final String productType;
  @JsonKey(name: 'unit_id')
  final int unitId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final bool sellable;
  final bool buyable;
  @JsonKey(name: 'editable_price')
  final bool editablePrice;
  @JsonKey(name: 'use_sn')
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
