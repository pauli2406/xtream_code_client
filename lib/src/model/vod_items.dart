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
    required this.stream_type,
    required this.stream_id,
    required this.stream_icon,
    required this.rating,
    required this.rating_5based,
    required this.added,
    required this.category_id,
    required this.category_ids,
    required this.container_extension,
    required this.custom_sid,
    required this.direct_source,
  });

  factory VodItem.fromJson(Map<String, dynamic> json) =>
      _$VodItemFromJson(json);
  final int num;
  final String name;
  final String title;
  final String year;
  final String stream_type;
  final int stream_id;
  final String stream_icon;
  final int rating;
  final int rating_5based;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  final String category_id;
  final List<int> category_ids;
  final String container_extension;
  final String custom_sid;
  final String direct_source;

  Map<String, dynamic> toJson() => _$VodItemToJson(this);
}
