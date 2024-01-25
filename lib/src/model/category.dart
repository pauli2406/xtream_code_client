import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.parentId,
  });
  String? categoryId;
  String? categoryName;
  int? parentId;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
