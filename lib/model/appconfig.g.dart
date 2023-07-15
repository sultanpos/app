// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appconfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigPrinter _$AppConfigPrinterFromJson(Map<String, dynamic> json) =>
    AppConfigPrinter(
      type: $enumDecodeNullable(_$AppConfigPrinterTypeEnumMap, json['type']),
      paperSize: $enumDecodeNullable(
          _$AppConfigPrinterPaperSizeEnumMap, json['paperSize']),
      name: json['name'] as String?,
      vendorId: json['vendorId'] as String?,
      productId: json['productId'] as String?,
      address: json['address'] as String?,
      title: json['title'] as String?,
      subtitles: (json['subtitles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      footnotes: (json['footnotes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AppConfigPrinterToJson(AppConfigPrinter instance) =>
    <String, dynamic>{
      'type': _$AppConfigPrinterTypeEnumMap[instance.type],
      'paperSize': _$AppConfigPrinterPaperSizeEnumMap[instance.paperSize],
      'name': instance.name,
      'vendorId': instance.vendorId,
      'productId': instance.productId,
      'address': instance.address,
      'title': instance.title,
      'subtitles': instance.subtitles,
      'footnotes': instance.footnotes,
    };

const _$AppConfigPrinterTypeEnumMap = {
  AppConfigPrinterType.usb: 'usb',
  AppConfigPrinterType.bluetooth: 'bluetooth',
};

const _$AppConfigPrinterPaperSizeEnumMap = {
  AppConfigPrinterPaperSize.paper58: 'paper58',
  AppConfigPrinterPaperSize.paper80: 'paper80',
};
