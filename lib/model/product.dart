import 'package:sultanpos/model/base.dart';

class ProductModel extends BaseModel {
  ProductModel.fromJson(super.json) : super.fromJson();

  @override
  String? path() {
    // TODO: implement path
    throw UnimplementedError();
  }

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) {
    // TODO: implement responseFromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
