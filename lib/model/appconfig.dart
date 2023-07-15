import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'appconfig.g.dart';

enum AppConfigPrinterType implements Comparable<AppConfigPrinterType> {
  @JsonValue('usb')
  usb('usb', 'USB'),
  @JsonValue('bluetooth')
  bluetooth('bluetooth', 'Bluetooth');

  final String value;
  final String text;
  const AppConfigPrinterType(this.value, this.text);
  @override
  int compareTo(AppConfigPrinterType other) {
    return 0;
  }
}

enum AppConfigPrinterPaperSize implements Comparable<AppConfigPrinterPaperSize> {
  @JsonValue('paper58')
  paper58('paper58', 'Kertas 58mm'),
  @JsonValue('paper80')
  paper80('paper80', 'Kertas 80mm');

  final String value;
  final String text;
  const AppConfigPrinterPaperSize(this.value, this.text);
  @override
  int compareTo(AppConfigPrinterPaperSize other) {
    return 0;
  }
}

@JsonSerializable()
class AppConfigPrinter {
  final AppConfigPrinterType? type;
  final AppConfigPrinterPaperSize? paperSize;
  final String? name;
  final String? vendorId;
  final String? productId;
  final String? address;
  final String? title;
  final List<String>? subtitles;
  final List<String>? footnotes;
  AppConfigPrinter({
    this.type,
    this.paperSize,
    this.name,
    this.vendorId,
    this.productId,
    this.address,
    this.title,
    this.subtitles,
    this.footnotes,
  });

  copyWith(
      {AppConfigPrinterType? type,
      AppConfigPrinterPaperSize? paperSize,
      String? name,
      String? vendorId,
      String? productId,
      String? address,
      String? title,
      List<String>? subtitles,
      List<String>? footnotes}) {
    return AppConfigPrinter(
      type: type ?? this.type,
      paperSize: paperSize ?? this.paperSize,
      name: name ?? this.name,
      vendorId: vendorId ?? this.vendorId,
      productId: productId ?? this.productId,
      address: address ?? this.address,
      title: title ?? this.title,
      subtitles: subtitles ?? this.subtitles,
      footnotes: footnotes ?? this.footnotes,
    );
  }

  factory AppConfigPrinter.fromJson(Map<String, dynamic> json) => _$AppConfigPrinterFromJson(json);

  factory AppConfigPrinter.fromJsonString(String jsonString) {
    return _$AppConfigPrinterFromJson(jsonDecode(jsonString));
  }

  Map<String, dynamic> toJson() => _$AppConfigPrinterToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
