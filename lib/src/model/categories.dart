import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/model/category.dart';

part 'categories.g.dart';

@JsonSerializable()
class Categories {

  Categories({
    required this.categories,
  });
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
  List<Category> categories;

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}
