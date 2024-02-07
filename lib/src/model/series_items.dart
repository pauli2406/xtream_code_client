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
    required this.streamType,
    required this.seriesId,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    required this.releaseDate,
    required this.lastModified,
    required this.rating,
    required this.rating5based,
    required this.backdropPath,
    required this.youtubeTrailer,
    required this.episodeRunTime,
    required this.categoryId,
    required this.categoryIds,
  });

  factory SeriesItem.fromJson(Map<String, dynamic> json) =>
      _$SeriesItemFromJson(json);
  final int num;
  final String name;
  final String title;
  final String year;
  @JsonKey(name: 'stream_type')
  final String streamType;
  @JsonKey(name: 'series_id')
  final int seriesId;
  final String cover;
  final String plot;
  final String cast;
  final String director;
  final String genre;
  DateTime releaseDate;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  @JsonKey(name: 'last_modified')
  final DateTime lastModified;
  final String rating;
  @JsonKey(name: 'rating_5based')
  final double rating5based;
  @JsonKey(name: 'backdrop_path')
  final List<String> backdropPath;
  @JsonKey(name: 'youtube_trailer')
  final String youtubeTrailer;
  @JsonKey(name: 'episode_run_time')
  final String episodeRunTime;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;

  Map<String, dynamic> toJson() => _$SeriesItemToJson(this);
}
