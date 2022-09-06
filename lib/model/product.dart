import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/buyprice.dart';
import 'package:sultanpos/model/category.dart';
import 'package:sultanpos/model/partner.dart';
import 'package:sultanpos/model/price.dart';
import 'package:sultanpos/model/unit.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel extends BaseModel {
  @JsonKey(name: 'parent_public_id')
  final String parentPublicId;
  @JsonKey(name: 'public_id')
  final String publicId;
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
  final bool sellable;
  final bool buyable;
  @JsonKey(name: 'editable_price')
  final bool editablePrice;
  @JsonKey(name: 'use_sn')
  final bool useSn;
  final UnitModel unit;
  final CategoryModel category;
  final PartnerModel partner;
  final List<PriceModel> prices;
  @JsonKey(name: 'buy_prices')
  final List<BuyPriceModel> buyPrices;

  ProductModel(
      this.parentPublicId,
      this.publicId,
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
      this.buyPrices);

  @override
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  @override
  String? path() => '/product';

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
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
  @JsonKey(name: 'unit_public_id')
  final String unitPublicId;
  @JsonKey(name: 'category_public_id')
  final String categoryPublicId;
  @JsonKey(name: 'partner_public_id')
  final String partnerPublicId;
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
      this.unitPublicId,
      this.partnerPublicId,
      this.categoryPublicId,
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
  @JsonKey(name: 'branch_public_id')
  final String branchPublicID;
  final int stock;

  ProductStockInsertModel(this.branchPublicID, this.stock);

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

@JsonSerializable()
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
  @JsonKey(name: 'unit_public_id')
  final String unitPublicId;
  @JsonKey(name: 'category_public_id')
  final String categoryPublicId;
  @JsonKey(name: 'partner_public_id')
  final String partnerPublicId;
  @JsonKey(name: 'buy_price')
  final int buyPrice;
  final bool sellable;
  final bool buyable;
  @JsonKey(name: 'editable_price')
  final bool editablePrice;
  @JsonKey(name: 'use_sn')
  final bool useSn;

  ProductUpdateModel(
    this.barcode,
    this.name,
    this.description,
    this.allBranch,
    this.mainImage,
    this.calculateStock,
    this.productType,
    this.unitPublicId,
    this.partnerPublicId,
    this.categoryPublicId,
    this.buyPrice,
    this.sellable,
    this.buyable,
    this.editablePrice,
    this.useSn,
  );

  @override
  factory ProductUpdateModel.fromJson(Map<String, dynamic> json) => _$ProductUpdateModelFromJson(json);

  @override
  String? path() => '/product';

  @override
  Map<String, dynamic> toJson() => _$ProductUpdateModelToJson(this);
}
