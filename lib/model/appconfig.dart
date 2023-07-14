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

@JsonSerializable()
class AppConfigPrinter {
  final AppConfigPrinterType? type;
  final String? name;
  final String? vendorId;
  final String? productId;
  final String? address;
  final String? title;
  final List<String> subtitles;
  final List<String> footnotes;
  AppConfigPrinter(
    this.type,
    this.name,
    this.vendorId,
    this.productId,
    this.address,
    this.title,
    this.subtitles,
    this.footnotes,
  );

  copyWith(
      {AppConfigPrinterType? type,
      String? name,
      String? vendorId,
      String? productId,
      String? address,
      String? title,
      List<String>? subtitles,
      List<String>? footnotes}) {
    return AppConfigPrinter(
      type ?? this.type,
      name ?? this.name,
      vendorId ?? this.vendorId,
      productId ?? this.productId,
      address ?? this.address,
      title ?? this.title,
      subtitles ?? this.subtitles,
      footnotes ?? this.footnotes,
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
