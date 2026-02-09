/// Live stream item from `get_live_streams`.
///
/// Date fields are normalized to UTC.
class LiveStreamItem {
  /// Creates a live stream item.
  const LiveStreamItem({
    this.num,
    this.name,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.epgChannelId,
    this.added,
    this.customSid,
    this.tvArchive,
    this.directSource,
    this.tvArchiveDuration,
    this.categoryId,
    this.categoryIds,
    this.thumbnail,
  });

  /// Provider-local ordering index.
  final int? num;

  /// Display name.
  final String? name;

  /// Stream type reported by server (typically `live`).
  final String? streamType;

  /// Stream identifier used by playback and EPG endpoints.
  final int? streamId;

  /// Stream icon URL.
  final String? streamIcon;

  /// EPG channel identifier.
  final String? epgChannelId;

  /// Creation timestamp in UTC.
  final DateTime? added;

  /// Optional custom SID.
  final int? customSid;

  /// Archive flag/value provided by server.
  final int? tvArchive;

  /// Direct source URL if provided.
  final String? directSource;

  /// TV archive duration value.
  final int? tvArchiveDuration;

  /// Primary category id.
  final int? categoryId;

  /// Multi-category ids when provider sends a list.
  final List<int>? categoryIds;

  /// Thumbnail image URL.
  final String? thumbnail;
}
