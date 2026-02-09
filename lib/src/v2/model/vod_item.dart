/// VOD list item from `get_vod_streams`.
///
/// Date fields are normalized to UTC.
class VodItem {
  /// Creates a VOD item.
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

  /// Stream identifier used by VOD info and playback URLs.
  final int? streamId;

  /// Provider-local ordering index.
  final int? num;

  /// Display name.
  final String? name;

  /// Alternative title field.
  final String? title;

  /// Release year as supplied by server.
  final String? year;

  /// Stream type (typically `movie`).
  final String? streamType;

  /// Poster/icon URL.
  final String? streamIcon;

  /// Rating value.
  final double? rating;

  /// Rating value normalized to a 5-based scale when provided.
  final double? rating5based;

  /// Added timestamp in UTC.
  final DateTime? added;

  /// Primary category id.
  final int? categoryId;

  /// Multi-category ids.
  final List<int>? categoryIds;

  /// Container extension used for playback URLs.
  final String? containerExtension;

  /// Optional custom SID.
  final String? customSid;

  /// Direct source URL if present.
  final String? directSource;
}
