import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'live_stream_items.g.dart';

@JsonSerializable()
class LiveStreamItems {

  LiveStreamItems({required this.liveStreamItems});

  factory LiveStreamItems.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamItemsFromJson(json);
  final List<LiveStreamItem> liveStreamItems;

  Map<String, dynamic> toJson() => _$LiveStreamItemsToJson(this);
}

@JsonSerializable()
class LiveStreamItem {

  LiveStreamItem({
    required this.num,
    required this.name,
    required this.streamType,
    required this.streamId,
    required this.streamIcon,
    required this.epgChannelId,
    required this.added,
    required this.customSid,
    required this.tvArchive,
    required this.directSource,
    required this.tvArchiveDuration,
    required this.categoryId,
    required this.categoryIds,
    required this.thumbnail,
  });

  factory LiveStreamItem.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamItemFromJson(json);
  final int num;
  final String name;
  @JsonKey(name: 'stream_type')
  final String streamType;
  @JsonKey(name: 'stream_id')
  final int streamId;
  @JsonKey(name: 'stream_icon')
  final String streamIcon;
  @JsonKey(name: 'epg_channel_id')
  final String epgChannelId;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  @JsonKey(name: 'custom_sid')
  final String customSid;
  @JsonKey(name: 'tv_archive')
  final int tvArchive;
  @JsonKey(name: 'direct_source')
  final String directSource;
  @JsonKey(name: 'tv_archive_duration')
  final int tvArchiveDuration;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;
  final String thumbnail;

  Map<String, dynamic> toJson() => _$LiveStreamItemToJson(this);
}
