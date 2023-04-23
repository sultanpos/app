import 'package:sultanpos/model/base.dart';

class InsertSuccessModel extends BaseModel {
  final int id;
  InsertSuccessModel(this.id);

  factory InsertSuccessModel.fromJson(Map<String, dynamic> json) {
    return InsertSuccessModel(json['id']);
  }

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
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
