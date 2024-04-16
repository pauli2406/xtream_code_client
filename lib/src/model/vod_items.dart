import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'vod_items.g.dart';

/// Represents a VOD (Video On Demand) item in Xtream Code.
@JsonSerializable()
class XTremeCodeVodItem {
  /// Creates a new instance of [XTremeCodeVodItem].
  XTremeCodeVodItem({
    required this.streamId,
    required this.num,
    required this.name,
    required this.title,
    required this.year,
    required this.streamType,
    required this.streamIcon,
    required this.rating,
    required this.rating5based,
    required this.added,
    required this.categoryId,
    required this.categoryIds,
    required this.containerExtension,
    required this.customSid,
    required this.directSource,
  });

  /// Creates a new instance of [XTremeCodeVodItem] from a JSON object.
  factory XTremeCodeVodItem.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeVodItemFromJson(json);

  /// The number of the VOD item.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? num;

  /// The name of the VOD item.
  final String? name;

  /// The title of the VOD item.
  final String? title;

  /// The year the VOD item was released.
  final String? year;

  /// The type of the stream of the VOD item.
  @JsonKey(name: 'stream_type')
  final String? streamType;

  /// The ID of the stream of the VOD item.
  @JsonKey(name: 'stream_id', fromJson: dynamicToIntConverter)
  final int? streamId;

  /// The icon of the stream of the VOD item.
  @JsonKey(name: 'stream_icon')
  final String? streamIcon;

  /// The rating of the VOD item.
  @JsonKey(fromJson: dynamicToDoubleConverter)
  final double? rating;

  /// The rating of the VOD item based on a scale of 5.
  @JsonKey(name: 'rating_5based', fromJson: dynamicToDoubleConverter)
  final double? rating5based;

  /// The date the VOD item was added.
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime? added;

  /// The ID of the category the VOD item belongs to.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  final int? categoryId;

  /// The IDs of the categories the VOD item belongs to.
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;

  /// The container extension of the VOD item.
  @JsonKey(name: 'container_extension')
  final String? containerExtension;

  /// The custom SID of the VOD item.
  @JsonKey(name: 'custom_sid', fromJson: dynamicToIntConverter)
  final int? customSid;

  /// The direct source of the VOD item.
  @JsonKey(name: 'direct_source')
  final String? directSource;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeVodItemToJson(this);
}
