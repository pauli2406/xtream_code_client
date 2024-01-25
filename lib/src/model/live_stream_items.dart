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
    required this.stream_type,
    required this.stream_id,
    required this.stream_icon,
    required this.epg_channel_id,
    required this.added,
    required this.custom_sid,
    required this.tv_archive,
    required this.direct_source,
    required this.tv_archive_duration,
    required this.category_id,
    required this.category_ids,
    required this.thumbnail,
  });

  factory LiveStreamItem.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamItemFromJson(json);
  final int num;
  final String name;
  final String stream_type;
  final int stream_id;
  final String stream_icon;
  final String epg_channel_id;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  final String custom_sid;
  final int tv_archive;
  final String direct_source;
  final int tv_archive_duration;
  final String category_id;
  final List<int> category_ids;
  final String thumbnail;

  Map<String, dynamic> toJson() => _$LiveStreamItemToJson(this);
}
