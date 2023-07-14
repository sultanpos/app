// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appconfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigPrinter _$AppConfigPrinterFromJson(Map<String, dynamic> json) =>
    AppConfigPrinter(
      $enumDecodeNullable(_$AppConfigPrinterTypeEnumMap, json['type']),
      json['name'] as String?,
      json['vendorId'] as String?,
      json['productId'] as String?,
      json['address'] as String?,
      json['title'] as String?,
      (json['subtitles'] as List<dynamic>).map((e) => e as String).toList(),
      (json['footnotes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AppConfigPrinterToJson(AppConfigPrinter instance) =>
    <String, dynamic>{
      'type': _$AppConfigPrinterTypeEnumMap[instance.type],
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
