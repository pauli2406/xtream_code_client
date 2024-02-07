import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
    required this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'category_name')
  String? categoryName;
  @JsonKey(name: 'parent_id')
  int? parentId;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
