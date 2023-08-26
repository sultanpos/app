import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/request.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel extends LocalSqlBase {
  final int id;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String code;
  final String description;
  final int? parentId;
  final bool isDefault;
  CategoryModel(
      this.id, this.updatedAt, this.deletedAt, this.name, this.code, this.description, this.parentId, this.isDefault);

  @override
  String? path() {
    return "/category";
  }

  @override
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  factory CategoryModel.empty() => CategoryModel(0, DateTime.now(), null, '', '', '', 0, false);

  @override
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  int getId() => id;

  @override
  String getTableName() {
    return "category";
  }

  @override
  DateTime getUpdatedAt() {
    return updatedAt;
  }

  @override
  Map<String, dynamic> toSqlite() {
    final ret = toJson();
    ret["is_default"] = isDefault ? 1 : 0;
    return ret;
  }

  @override
  factory CategoryModel.fromSqlite(Map<String, dynamic> json) {
    final newJson = Map<String, dynamic>.from(json);
    newJson["is_default"] = json["is_default"] != 0;
    return _$CategoryModelFromJson(newJson);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryInsertModel extends BaseModel {
  final String name;
  final String code;
  final String description;
  final int parentId;
  CategoryInsertModel(this.name, this.code, this.description, this.parentId);

  @override
  String? path() {
    return "/category";
  }

  @override
  factory CategoryInsertModel.fromJson(Map<String, dynamic> json) => _$CategoryInsertModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => InsertSuccessModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryInsertModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryUpdateModel extends BaseModel {
  final String name;
  final String code;
  final String description;
  final int parentId;
  CategoryUpdateModel(this.name, this.code, this.description, this.parentId);

  @override
  String? path() {
    return "/category";
  }

  @override
  factory CategoryUpdateModel.fromJson(Map<String, dynamic> json) => _$CategoryUpdateModelFromJson(json);

  @override
  BaseModel? responseFromJson(Map<String, dynamic> json) => UpdateSuccessModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryUpdateModelToJson(this);
}
