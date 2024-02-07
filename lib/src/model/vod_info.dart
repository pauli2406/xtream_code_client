import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'vod_info.g.dart';

@JsonSerializable()
class VodInfo {

  VodInfo({required this.info, required this.movie_data});

  factory VodInfo.fromJson(Map<String, dynamic> json) =>
      _$VodInfoFromJson(json);
  final Info info;
  final MovieData movie_data;

  Map<String, dynamic> toJson() => _$VodInfoToJson(this);
}

@JsonSerializable()
class Info {

  Info({
    required this.kinopoisk_url,
    required this.tmdb_id,
    required this.name,
    required this.o_name,
    required this.cover_big,
    required this.movie_image,
    required this.release_date,
    required this.episode_run_time,
    required this.youtube_trailer,
    required this.director,
    required this.actors,
    required this.cast,
    required this.description,
    required this.plot,
    required this.age,
    required this.mpaa_rating,
    required this.rating_count_kinopoisk,
    required this.country,
    required this.genre,
    required this.backdrop_path,
    required this.duration_secs,
    required this.duration,
    required this.bitrate,
    required this.rating,
    required this.releasedate,
    required this.subtitles,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  final String kinopoisk_url;
  final int tmdb_id;
  final String name;
  final String o_name;
  final String cover_big;
  final String movie_image;
  final DateTime release_date;
  final int episode_run_time;
  final String youtube_trailer;
  final String director;
  final String actors;
  final String cast;
  final String description;
  final String plot;
  final String age;
  final String mpaa_rating;
  final int rating_count_kinopoisk;
  final String country;
  final String genre;
  final List<String> backdrop_path;
  final int duration_secs;
  final String duration;
  final int bitrate;
  final int rating;
  final DateTime releasedate;
  final List<dynamic> subtitles;

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class MovieData {

  MovieData({
    required this.streamId,
    required this.name,
    required this.title,
    required this.year,
    required this.added,
    required this.categoryId,
    required this.categoryIds,
    required this.containerExtension,
    required this.customSid,
    required this.directSource,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);
  @JsonKey(name: 'stream_id')
  final int streamId;
  final String name;
  final String title;
  final String year;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'categoryIds')
  final List<int> categoryIds;
  @JsonKey(name: 'containerExtension')
  final String containerExtension;
  @JsonKey(name: 'custom_sid')
  final String customSid;
  @JsonKey(name: 'direct_source')
  final String directSource;

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);
}
