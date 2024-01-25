import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'series_info.g.dart';

@JsonSerializable()
class SeriesInfo {

  SeriesInfo({
    required this.seasons,
    required this.info,
    required this.episodes,
  });

  factory SeriesInfo.fromJson(Map<String, dynamic> json) =>
      _$SeriesInfoFromJson(json);
  final List<Season> seasons;
  final Info info;
  final Map<String, List<Episode>> episodes;

  Map<String, dynamic> toJson() => _$SeriesInfoToJson(this);
}

@JsonSerializable()
class Season {

  Season({
    required this.air_date,
    required this.episode_count,
    required this.id,
    required this.name,
    required this.overview,
    required this.season_number,
    required this.vote_average,
    required this.cover,
    required this.cover_big,
  });

  factory Season.fromJson(Map<String, dynamic> json) =>
      _$SeasonFromJson(json);
  final String air_date;
  final int episode_count;
  final int id;
  final String name;
  final String overview;
  final int season_number;
  final int vote_average;
  final String cover;
  final String cover_big;

  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}

@JsonSerializable()
class Info {

  Info({
    required this.name,
    required this.title,
    required this.year,
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

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  final String name;
  final String title;
  final String year;
  final String cover;
  final String plot;
  final String cast;
  final String director;
  final String genre;
  final DateTime release_date;
  final DateTime releaseDate;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime last_modified;
  final String rating;
  final double rating_5based;
  final List<String> backdrop_path;
  final String youtube_trailer;
  final String episode_run_time;
  final String category_id;
  final List<int> category_ids;

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Episode {

  Episode({
    required this.id,
    required this.episode_num,
    required this.title,
    required this.container_extension,
    required this.info,
    required this.subtitles,
    required this.custom_sid,
    required this.added,
    required this.season,
    required this.direct_source,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  final String id;
  final String episode_num;
  final String title;
  final String container_extension;
  final EpisodeInfo info;
  final List<String> subtitles;
  final String custom_sid;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  final int season;
  final String direct_source;

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class EpisodeInfo {

  EpisodeInfo({
    required this.tmdb_id,
    required this.release_date,
    required this.plot,
    required this.duration_secs,
    required this.duration,
    required this.movie_image,
    required this.bitrate,
    required this.rating,
    required this.season,
    required this.cover_big,
  });

  factory EpisodeInfo.fromJson(Map<String, dynamic> json) =>
      _$EpisodeInfoFromJson(json);
  final int tmdb_id;
  final DateTime release_date;
  final String plot;
  final int duration_secs;
  final String duration;
  final String movie_image;
  final int bitrate;
  final double rating;
  final int season;
  final String cover_big;

  Map<String, dynamic> toJson() => _$EpisodeInfoToJson(this);

}
