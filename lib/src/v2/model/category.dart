class Category {
  const Category({
    this.categoryId,
    this.categoryName,
    this.parentId,
  });

  final int? categoryId;
  final String? categoryName;
  final int? parentId;
}
