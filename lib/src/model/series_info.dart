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
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.voteAverage,
    required this.cover,
    required this.coverBig,
  });

  factory Season.fromJson(Map<String, dynamic> json) =>
      _$SeasonFromJson(json);
  @JsonKey(name: 'air_date')
  final String airDate;
  @JsonKey(name: 'episode_count')
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @JsonKey(name: 'vote_average')
  final int voteAverage;
  final String cover;
  @JsonKey(name: 'cover_big')
  final String coverBig;

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

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  final String name;
  final String title;
  final String year;
  final String cover;
  final String plot;
  final String cast;
  final String director;
  final String genre;
  final DateTime releaseDate;
  @JsonKey(name: 'last_modified', fromJson: dateTimeFromEpochSeconds)
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
  @JsonKey(name: 'categoryIds')
  final List<int> categoryIds;

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Episode {

  Episode({
    required this.id,
    required this.episodeNum,
    required this.title,
    required this.containerExtension,
    required this.info,
    required this.subtitles,
    required this.customSid,
    required this.added,
    required this.season,
    required this.directSource,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  final String id;
  @JsonKey(name: 'episode_num')
  final String episodeNum;
  final String title;
  @JsonKey(name: 'container_extension')
  final String containerExtension;
  final EpisodeInfo info;
  final List<String> subtitles;
  @JsonKey(name: 'custom_sid')
  final String customSid;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime added;
  final int season;
  @JsonKey(name: 'direct_source')
  final String directSource;

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class EpisodeInfo {

  EpisodeInfo({
    required this.tmdbId,
    required this.releaseDate,
    required this.plot,
    required this.durationSecs,
    required this.duration,
    required this.movieImage,
    required this.bitrate,
    required this.rating,
    required this.season,
    required this.coverBig,
  });

  factory EpisodeInfo.fromJson(Map<String, dynamic> json) =>
      _$EpisodeInfoFromJson(json);
  @JsonKey(name: 'tmdb_id')
  final int tmdbId;
  @JsonKey(name: 'release_date')
  final DateTime releaseDate;
  final String plot;
  @JsonKey(name: 'duration_secs')
  final int durationSecs;
  final String duration;
  @JsonKey(name: 'movie_image')
  final String movieImage;
  final int bitrate;
  final double rating;
  final int season;
  @JsonKey(name: 'cover_big')
  final String coverBig;

  Map<String, dynamic> toJson() => _$EpisodeInfoToJson(this);

}
