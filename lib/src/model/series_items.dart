import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'series_items.g.dart';

@JsonSerializable()
class SeriesItems {

  SeriesItems({required this.seriesItems});

  factory SeriesItems.fromJson(Map<String, dynamic> json) =>
      _$SeriesItemsFromJson(json);
  final List<SeriesItem> seriesItems;

  Map<String, dynamic> toJson() => _$SeriesItemsToJson(this);
}

@JsonSerializable()
class SeriesItem {

  SeriesItem({
    required this.num,
    required this.name,
    required this.title,
    required this.year,
    required this.stream_type,
    required this.series_id,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    required this.release_date,
    required this.releaseDate,
    required this.last_modified,
    required this.rating,
    required this.rating_5based,
    required this.backdrop_path,
    required this.youtube_trailer,
    required this.episode_run_time,
    required this.category_id,
    required this.category_ids,
  });

  factory SeriesItem.fromJson(Map<String, dynamic> json) =>
      _$SeriesItemFromJson(json);
  final int num;
  final String name;
  final String title;
  final String year;
  final String stream_type;
  final int series_id;
  final String cover;
  final String plot;
  final String cast;
  final String director;
  final String genre;
  DateTime release_date;
  DateTime releaseDate;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime last_modified;
  final String rating;
  final double rating_5based;
  final List<String> backdrop_path;
  final String youtube_trailer;
  final String episode_run_time;
  final String category_id;
  final List<int> category_ids;

  Map<String, dynamic> toJson() => _$SeriesItemToJson(this);
}
