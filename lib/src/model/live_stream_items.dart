import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'live_stream_items.g.dart';

/// Represents a live stream item in Xtream Code.
@JsonSerializable()
class XTremeCodeLiveStreamItem {
  /// Creates a new instance of [XTremeCodeLiveStreamItem].
  XTremeCodeLiveStreamItem({
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

  /// Creates a new instance of [XTremeCodeLiveStreamItem] from a JSON object.
  factory XTremeCodeLiveStreamItem.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeLiveStreamItemFromJson(json);

  /// The number of the live stream item.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? num;

  /// The name of the live stream item.
  final String? name;

  /// The type of the stream.
  @JsonKey(name: 'stream_type')
  final String? streamType;

  /// The ID of the stream.
  @JsonKey(name: 'stream_id', fromJson: dynamicToIntConverter)
  final int? streamId;

  /// The icon of the stream.
  @JsonKey(name: 'stream_icon')
  final String? streamIcon;

  /// The ID of the EPG channel.
  @JsonKey(name: 'epg_channel_id')
  final String? epgChannelId;

  /// The date when the live stream item was added.
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime? added;

  /// The custom SID of the live stream item.
  @JsonKey(name: 'custom_sid', fromJson: dynamicToIntConverter)
  final int? customSid;

  /// The TV archive of the live stream item.
  @JsonKey(name: 'tv_archive', fromJson: dynamicToIntConverter)
  final int? tvArchive;

  /// The direct source of the live stream item.
  @JsonKey(name: 'direct_source')
  final String? directSource;

  /// The duration of the TV archive.
  @JsonKey(name: 'tv_archive_duration', fromJson: dynamicToIntConverter)
  final int? tvArchiveDuration;

  /// The ID of the category.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  final int? categoryId;

  /// The IDs of the categories.
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;

  /// The thumbnail of the live stream item.
  final String? thumbnail;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeLiveStreamItemToJson(this);
}
