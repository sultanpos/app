// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['parent_public_id'] as String,
      json['public_id'] as String,
      json['barcode'] as String,
      json['name'] as String,
      json['description'] as String,
      json['all_branch'] as bool,
      json['main_image'] as String,
      json['calculate_stock'] as bool,
      json['product_type'] as String,
      json['sellable'] as bool,
      json['buyable'] as bool,
      json['editable_price'] as bool,
      json['use_sn'] as bool,
      UnitModel.fromJson(json['unit'] as Map<String, dynamic>),
      CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'parent_public_id': instance.parentPublicId,
      'public_id': instance.publicId,
      'barcode': instance.barcode,
      'name': instance.name,
      'description': instance.description,
      'all_branch': instance.allBranch,
      'main_image': instance.mainImage,
      'calculate_stock': instance.calculateStock,
      'product_type': instance.productType,
      'sellable': instance.sellable,
      'buyable': instance.buyable,
      'editable_price': instance.editablePrice,
      'use_sn': instance.useSn,
      'unit': instance.unit,
      'category': instance.category,
      'partner': instance.partner,
    };

ProductInsertModel _$ProductInsertModelFromJson(Map<String, dynamic> json) =>
    ProductInsertModel(
      json['barcode'] as String,
      json['name'] as String,
      json['description'] as String,
      json['all_branch'] as bool,
      json['main_image'] as String,
      json['calculate_stock'] as bool,
      json['product_type'] as String,
      json['sellable'] as bool,
      json['buyable'] as bool,
      json['editable_price'] as bool,
      json['use_sn'] as bool,
      json['unit_public_id'] as String,
      json['partner_public_id'] as String,
      json['category_public_id'] as String,
      (json['branches'] as List<dynamic>).map((e) => e as String).toList(),
      json['buy_price'] as int,
      (json['stocks'] as List<dynamic>)
          .map((e) =>
              ProductStockInsertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ProductPriceInsertModel.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductInsertModelToJson(ProductInsertModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'description': instance.description,
      'all_branch': instance.allBranch,
      'main_image': instance.mainImage,
      'calculate_stock': instance.calculateStock,
      'product_type': instance.productType,
      'unit_public_id': instance.unitPublicId,
      'category_public_id': instance.categoryPublicId,
      'partner_public_id': instance.partnerPublicId,
      'branches': instance.branches,
      'buy_price': instance.buyPrice,
      'sellable': instance.sellable,
      'buyable': instance.buyable,
      'editable_price': instance.editablePrice,
      'use_sn': instance.useSn,
      'stocks': instance.stocks,
      'price': instance.price,
    };

ProductStockInsertModel _$ProductStockInsertModelFromJson(
        Map<String, dynamic> json) =>
    ProductStockInsertModel(
      json['branch_public_id'] as String,
      json['stock'] as int,
    );

Map<String, dynamic> _$ProductStockInsertModelToJson(
        ProductStockInsertModel instance) =>
    <String, dynamic>{
      'branch_public_id': instance.branchPublicID,
      'stock': instance.stock,
    };

ProductPriceInsertModel _$ProductPriceInsertModelFromJson(
        Map<String, dynamic> json) =>
    ProductPriceInsertModel(
      json['price0'] as int,
      json['count0'] as int,
      json['discount_formula0'] as String,
      json['discount0'] as int,
      json['price1'] as int,
      json['count1'] as int,
      json['discount_formula1'] as String,
      json['discount1'] as int,
      json['price2'] as int,
      json['count2'] as int,
      json['discount_formula2'] as String,
      json['discount2'] as int,
      json['price3'] as int,
      json['count3'] as int,
      json['discount_formula3'] as String,
      json['discount3'] as int,
      json['price4'] as int,
      json['count4'] as int,
      json['discount_formula4'] as String,
      json['discount4'] as int,
    );

Map<String, dynamic> _$ProductPriceInsertModelToJson(
        ProductPriceInsertModel instance) =>
    <String, dynamic>{
      'price0': instance.price0,
      'count0': instance.count0,
      'discount_formula0': instance.discountFormula0,
      'discount0': instance.discount0,
      'price1': instance.price1,
      'count1': instance.count1,
      'discount_formula1': instance.discountFormula1,
      'discount1': instance.discount1,
      'price2': instance.price2,
      'count2': instance.count2,
      'discount_formula2': instance.discountFormula2,
      'discount2': instance.discount2,
      'price3': instance.price3,
      'count3': instance.count3,
      'discount_formula3': instance.discountFormula3,
      'discount3': instance.discount3,
      'price4': instance.price4,
      'count4': instance.count4,
      'discount_formula4': instance.discountFormula4,
      'discount4': instance.discount4,
    };

ProductUpdateModel _$ProductUpdateModelFromJson(Map<String, dynamic> json) =>
    ProductUpdateModel(
      json['barcode'] as String,
      json['name'] as String,
      json['description'] as String,
      json['all_branch'] as bool,
      json['main_image'] as String,
      json['calculate_stock'] as bool,
      json['product_type'] as String,
      json['unit_public_id'] as String,
      json['partner_public_id'] as String,
      json['category_public_id'] as String,
      json['buy_price'] as int,
      json['sellable'] as bool,
      json['buyable'] as bool,
      json['editable_price'] as bool,
      json['use_sn'] as bool,
    );

Map<String, dynamic> _$ProductUpdateModelToJson(ProductUpdateModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'description': instance.description,
      'all_branch': instance.allBranch,
      'main_image': instance.mainImage,
      'calculate_stock': instance.calculateStock,
      'product_type': instance.productType,
      'unit_public_id': instance.unitPublicId,
      'category_public_id': instance.categoryPublicId,
      'partner_public_id': instance.partnerPublicId,
      'buy_price': instance.buyPrice,
      'sellable': instance.sellable,
      'buyable': instance.buyable,
      'editable_price': instance.editablePrice,
      'use_sn': instance.useSn,
    };
