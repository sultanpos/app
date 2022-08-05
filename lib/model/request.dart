import 'package:sultanpos/model/base.dart';

class InsertSuccessModel implements BaseModel {
  final String publicId;
  InsertSuccessModel(this.publicId);

  factory InsertSuccessModel.fromJson(Map<String, dynamic> json) {
    return InsertSuccessModel(json['public_id']);
  }

  @override
  String? path() => null;

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "public_id": publicId,
    };
  }
}

class UpdateSuccessModel implements BaseModel {
  final String publicId;
  UpdateSuccessModel(this.publicId);

  factory UpdateSuccessModel.fromJson(Map<String, dynamic> json) {
    return UpdateSuccessModel(json['public_id']);
  }

  @override
  String? path() => null;

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "public_id": publicId,
    };
  }
}
