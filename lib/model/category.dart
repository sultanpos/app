import 'package:sultanpos/model/base.dart';
import 'package:sultanpos/model/request.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel extends BaseModel {
  final int id;
  final String name;
  final String code;
  final String description;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'is_default')
  final bool isDefault;
  CategoryModel(this.id, this.name, this.code, this.description, this.parentId, this.isDefault);

  @override
  String? path() {
    return "/category";
  }

  @override
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  int getId() => id;
}

@JsonSerializable()
class CategoryInsertModel extends BaseModel {
  final String name;
  final String code;
  final String description;
  @JsonKey(name: 'parent_public_id')
  final int parentParentId;
  CategoryInsertModel(this.name, this.code, this.description, this.parentParentId);

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
  @JsonKey(name: 'parent_public_id')
  final int parentParentId;
  CategoryUpdateModel(this.name, this.code, this.description, this.parentParentId);

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
