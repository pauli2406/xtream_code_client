import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'series_info.g.dart';

/// Represents the information about a series in Xtream Code.
@JsonSerializable()
class XTremeCodeSeriesInfo {
  /// Creates a new instance of [XTremeCodeSeriesInfo].
  XTremeCodeSeriesInfo({
    required this.seasons,
    required this.info,
    required this.episodes,
  });

  /// Creates a new instance of [XTremeCodeSeriesInfo] from a JSON object.
  factory XTremeCodeSeriesInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeSeriesInfoFromJson(json);

  /// The seasons of the series.
  final List<XTremeCodeSeason> seasons;

  /// The information about the series.
  final XTremeCodeInfo info;

  /// The episodes of the series, grouped by season.
  final Map<String, List<XTremeCodeEpisode>> episodes;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeSeriesInfoToJson(this);
}

/// Represents a season in Xtream Code.
@JsonSerializable()
class XTremeCodeSeason {
  /// Creates a new instance of [XTremeCodeSeason].
  XTremeCodeSeason({
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

  /// Creates a new instance of [XTremeCodeSeason] from a JSON object.
  factory XTremeCodeSeason.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeSeasonFromJson(json);

  /// The air date of the season.
  @JsonKey(name: 'air_date')
  final String airDate;

  /// The count of episodes in the season.
  @JsonKey(name: 'episode_count')
  final int episodeCount;

  /// The ID of the season.
  final int id;

  /// The name of the season.
  final String name;

  /// The overview of the season.
  final String overview;

  /// The number of the season.
  @JsonKey(name: 'season_number')
  final int seasonNumber;

  /// The average vote of the season.
  @JsonKey(name: 'vote_average')
  final int voteAverage;

  /// The cover image of the season.
  final String cover;

  /// The big cover image of the season.
  @JsonKey(name: 'cover_big')
  final String coverBig;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeSeasonToJson(this);
}

/// Represents the information about a series in Xtream Code.
@JsonSerializable()
class XTremeCodeInfo {
  /// Creates a new instance of [XTremeCodeInfo].
  XTremeCodeInfo({
    this.name,
    this.title,
    this.year,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.releaseDate,
    this.lastModified,
    this.rating,
    this.rating5based,
    this.backdropPath = const [],
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds = const [],
  });

  /// Creates a new instance of [XTremeCodeInfo] from a JSON object.
  factory XTremeCodeInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeInfoFromJson(json);

  /// The name of the series.
  final String? name;

  /// The title of the series.
  final String? title;

  /// The year of the series.
  final String? year;

  /// The cover image of the series.
  final String? cover;

  /// The plot of the series.
  final String? plot;

  /// The cast of the series.
  final String? cast;

  /// The director of the series.
  final String? director;

  /// The genre of the series.
  final String? genre;

  /// The release date of the series.
  final String? releaseDate;

  /// The last modified date of the series.
  @JsonKey(name: 'last_modified', fromJson: dateTimeFromEpochSeconds)
  final DateTime? lastModified;

  /// The rating of the series.
  @JsonKey(fromJson: dynamicToDoubleConverter)
  final double? rating;

  /// The rating of the series based on a 5-point scale.
  @JsonKey(name: 'rating_5based', fromJson: dynamicToDoubleConverter)
  final double? rating5based;

  /// The backdrop path of the series.
  @JsonKey(name: 'backdrop_path')
  final List<String> backdropPath;

  /// The YouTube trailer of the series.
  @JsonKey(name: 'youtube_trailer')
  final String? youtubeTrailer;

  /// The runtime of each episode in the series.
  @JsonKey(name: 'episode_run_time', fromJson: dynamicToIntConverter)
  final int? episodeRunTime;

  /// The ID of the category of the series.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  final int? categoryId;

  /// The IDs of the categories of the series.
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeInfoToJson(this);
}

/// Represents an episode in Xtream Code.
@JsonSerializable()
class XTremeCodeEpisode {
  /// Creates a new instance of [XTremeCodeEpisode].
  XTremeCodeEpisode({
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

  /// Creates a new instance of [XTremeCodeEpisode] from a JSON object.
  factory XTremeCodeEpisode.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeEpisodeFromJson(json);

  /// The ID of the episode.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? id;

  /// The number of the episode.
  @JsonKey(name: 'episode_num', fromJson: dynamicToIntConverter)
  final int? episodeNum;

  /// The title of the episode.
  final String title;

  /// The container extension of the episode.
  @JsonKey(name: 'container_extension')
  final String containerExtension;

  /// The information about the episode.
  final XTremeCodeEpisodeInfo info;

  /// The subtitles of the episode.
  final List<String> subtitles;

  /// The custom SID of the episode.
  @JsonKey(name: 'custom_sid', fromJson: dynamicToIntConverter)
  final int? customSid;

  /// The date when the episode was added.
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime? added;

  /// The season of the episode.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? season;

  /// The direct source of the episode.
  @JsonKey(name: 'direct_source')
  final String directSource;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeEpisodeToJson(this);
}

/// Represents the information about an episode in Xtream Code.
@JsonSerializable()
class XTremeCodeEpisodeInfo {
  /// Creates a new instance of [XTremeCodeEpisodeInfo].
  XTremeCodeEpisodeInfo({
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

  /// Creates a new instance of [XTremeCodeEpisodeInfo] from a JSON object.
  factory XTremeCodeEpisodeInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeEpisodeInfoFromJson(json);

  /// The ID of the episode in The Movie Database (TMDb).
  @JsonKey(name: 'tmdb_id')
  final int? tmdbId;

  /// The release date of the episode.
  final String? releaseDate;

  /// The plot of the episode.
  final String? plot;

  /// The duration of the episode in seconds.
  @JsonKey(name: 'duration_secs', fromJson: dynamicToIntConverter)
  final int? durationSecs;

  /// The duration of the episode.
  final String? duration;

  /// The image of the episode.
  @JsonKey(name: 'movie_image')
  final String? movieImage;

  /// The bitrate of the episode.
  final int? bitrate;

  /// The rating of the episode.
  final double? rating;

  /// The season of the episode.
  final int? season;

  /// The big cover image of the episode.
  @JsonKey(name: 'cover_big')
  final String? coverBig;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeEpisodeInfoToJson(this);
}
