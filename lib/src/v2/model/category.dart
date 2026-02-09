/// Category returned by live, VOD, or series category endpoints.
class Category {
  /// Creates a category model.
  const Category({
    this.categoryId,
    this.categoryName,
    this.parentId,
  });

  /// Numeric category identifier.
  final int? categoryId;

  /// Human-readable category label.
  final String? categoryName;

  /// Parent category identifier when hierarchical categories are used.
  final int? parentId;
}
