class LiveStreamItem {
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

  final int? num;
  final String? name;
  final String? streamType;
  final int? streamId;
  final String? streamIcon;
  final String? epgChannelId;
  final DateTime? added;
  final int? customSid;
  final int? tvArchive;
  final String? directSource;
  final int? tvArchiveDuration;
  final int? categoryId;
  final List<int>? categoryIds;
  final String? thumbnail;
}
