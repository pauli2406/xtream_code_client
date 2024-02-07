import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'vod_items.g.dart';

@JsonSerializable()
class VodItems {

  VodItems({required this.vodItems});

  factory VodItems.fromJson(Map<String, dynamic> json) =>
      _$VodItemsFromJson(json);
  final List<VodItem> vodItems;

  Map<String, dynamic> toJson() => _$VodItemsToJson(this);
}

@JsonSerializable()
class VodItem {

  VodItem({
    required this.num,
    required this.name,
    required this.title,
    required this.year,
    required this.streamType,
    required this.streamId,
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

  factory VodItem.fromJson(Map<String, dynamic> json) =>
      _$VodItemFromJson(json);
  final int num;
  final String name;
  final String title;
  final String year;
  @JsonKey(name: 'stream_type')
  final String streamType;
  @JsonKey(name: 'stream_id')
  final int streamId;
  @JsonKey(name: 'stream_icon')
  final String streamIcon;
  final int rating;
  @JsonKey(name: 'rating_5based')
  final int rating5based;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;
  @JsonKey(name: 'container_extension')
  final String containerExtension;
  @JsonKey(name: 'customSid')
  final String customSid;
  @JsonKey(name: 'direct_source')
  final String directSource;

  Map<String, dynamic> toJson() => _$VodItemToJson(this);
}
