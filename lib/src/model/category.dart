import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'category.g.dart';

/// Represents a category in XTremeCode.
@JsonSerializable()
class XTremeCodeCategory {
  /// Creates a new instance of [XTremeCodeCategory].
  XTremeCodeCategory({
    required this.categoryId,
    required this.categoryName,
    required this.parentId,
  });

  /// Creates a new instance of [XTremeCodeCategory] from a JSON map.
  factory XTremeCodeCategory.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeCategoryFromJson(json);

  /// The ID of the category.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  int? categoryId;

  /// The name of the category.
  @JsonKey(name: 'category_name')
  String? categoryName;

  /// The ID of the parent category.
  @JsonKey(name: 'parent_id', fromJson: dynamicToIntConverter)
  int? parentId;

  /// Converts this [XTremeCodeCategory] instance to a JSON map.
  Map<String, dynamic> toJson() => _$XTremeCodeCategoryToJson(this);
}
