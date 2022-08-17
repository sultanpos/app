import 'package:sultanpos/model/base.dart';

class InsertSuccessModel extends BaseModel {
  final String publicId;
  InsertSuccessModel(this.publicId);

  factory InsertSuccessModel.fromJson(Map<String, dynamic> json) {
    return InsertSuccessModel(json['public_id']);
  }

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "public_id": publicId,
    };
  }
}

class UpdateSuccessModel extends BaseModel {
  UpdateSuccessModel();

  factory UpdateSuccessModel.fromJson(Map<String, dynamic> json) {
    return UpdateSuccessModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
