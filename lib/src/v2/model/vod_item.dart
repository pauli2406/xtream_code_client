class VodItem {
  const VodItem({
    this.streamId,
    this.num,
    this.name,
    this.title,
    this.year,
    this.streamType,
    this.streamIcon,
    this.rating,
    this.rating5based,
    this.added,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  final int? streamId;
  final int? num;
  final String? name;
  final String? title;
  final String? year;
  final String? streamType;
  final String? streamIcon;
  final double? rating;
  final double? rating5based;
  final DateTime? added;
  final int? categoryId;
  final List<int>? categoryIds;
  final String? containerExtension;
  final String? customSid;
  final String? directSource;
}
