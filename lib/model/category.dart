import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/request.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel extends LocalSqlBase {
  final int id;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String name;
  final String code;
  final String description;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'is_default')
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

@JsonSerializable()
class CategoryInsertModel extends BaseModel {
  final String name;
  final String code;
  final String description;
  @JsonKey(name: 'parent_id')
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

@JsonSerializable()
class CategoryUpdateModel extends BaseModel {
  final String name;
  final String code;
  final String description;
  @JsonKey(name: 'parent_id')
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
