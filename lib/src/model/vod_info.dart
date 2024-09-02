import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'vod_info.g.dart';

/// Represents the VOD (Video On Demand) information in Xtream Code.
@JsonSerializable()
class XTremeCodeVodInfo {
  /// Creates a new instance of [XTremeCodeVodInfo].
  XTremeCodeVodInfo({
    required this.info,
    required this.movieData,
  });

  /// Creates a new instance of [XTremeCodeVodInfo] from a JSON object.
  factory XTremeCodeVodInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeVodInfoFromJson(json);

  /// The information about the VOD.
  final XTremeCodeInfoVod info;

  /// The data about the movie in the VOD.
  @JsonKey(name: 'movie_data')
  final XTremeCodeMovieData movieData;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeVodInfoToJson(this);
}

/// Represents the VOD (Video On Demand) information in Xtream Code.
@JsonSerializable()
class XTremeCodeInfoVod {
  /// Creates a new instance of [XTremeCodeInfoVod].
  XTremeCodeInfoVod({
    required this.kinopoiskUrl,
    required this.tmdbId,
    required this.name,
    required this.oName,
    required this.coverBig,
    required this.movieImage,
    required this.releaseDate,
    required this.episodeRunTime,
    required this.youtubeTrailer,
    required this.director,
    required this.actors,
    required this.cast,
    required this.description,
    required this.plot,
    required this.age,
    required this.mpaaRating,
    required this.ratingCountKinopoisk,
    required this.country,
    required this.genre,
    required this.backdropPath,
    required this.durationSecs,
    required this.duration,
    required this.bitrate,
    required this.rating,
    required this.releasedate,
    required this.subtitles,
  });

  /// Creates a new instance of [XTremeCodeInfoVod] from a JSON object.
  factory XTremeCodeInfoVod.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeInfoVodFromJson(json);

  /// The URL of the movie on Kinopoisk.
  @JsonKey(name: 'kinopoisk_url')
  final String? kinopoiskUrl;

  /// The ID of the movie in The Movie Database (TMDb).
  @JsonKey(name: 'tmdb_id', fromJson: dynamicToIntConverter)
  final int? tmdbId;

  /// The name of the movie.
  final String? name;

  /// The original name of the movie.
  @JsonKey(name: 'o_name')
  final String? oName;

  /// The big cover image of the movie.
  @JsonKey(name: 'cover_big')
  final String? coverBig;

  /// The image of the movie.
  @JsonKey(name: 'movie_image')
  final String? movieImage;

  /// The release date of the movie.
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  /// The runtime of the episode in minutes.
  @JsonKey(name: 'episode_run_time', fromJson: dynamicToIntConverter)
  final int? episodeRunTime;

  /// The URL of the movie's trailer on YouTube.
  @JsonKey(name: 'youtube_trailer')
  final String? youtubeTrailer;

  /// The director of the movie.
  final String? director;

  /// The actors in the movie.
  final String? actors;

  /// The cast of the movie.
  final String? cast;

  /// The description of the movie.
  final String? description;

  /// The plot of the movie.
  final String? plot;

  /// The age rating of the movie.
  final String? age;

  /// The MPAA rating of the movie.
  @JsonKey(name: 'mpaa_rating')
  final String? mpaaRating;

  /// The rating count of the movie on Kinopoisk.
  @JsonKey(name: 'rating_count_kinopoisk', fromJson: dynamicToIntConverter)
  final int? ratingCountKinopoisk;

  /// The country where the movie was made.
  final String? country;

  /// The genre of the movie.
  final String? genre;

  /// The backdrop images of the movie.
  @JsonKey(name: 'backdrop_path')
  final List<String>? backdropPath;

  /// The duration of the movie in seconds.
  @JsonKey(name: 'duration_secs', fromJson: dynamicToIntConverter)
  final int? durationSecs;

  /// The duration of the movie.
  final String? duration;

  /// The bitrate of the movie.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? bitrate;

  /// The rating of the movie.
  @JsonKey(fromJson: dynamicToDoubleConverter)
  final double? rating;

  /// The release date of the movie.
  final DateTime? releasedate;

  /// The subtitles of the movie.
  final List<dynamic>? subtitles;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeInfoVodToJson(this);
}

/// Represents the movie data in Xtream Code.
@JsonSerializable()
class XTremeCodeMovieData {
  /// Creates a new instance of [XTremeCodeMovieData].
  XTremeCodeMovieData({
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

  /// Creates a new instance of [XTremeCodeMovieData] from a JSON object.
  factory XTremeCodeMovieData.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeMovieDataFromJson(json);

  /// The stream ID of the movie.
  @JsonKey(name: 'stream_id', fromJson: dynamicToIntConverter)
  final int? streamId;

  /// The name of the movie.
  final String name;

  /// The title of the movie.
  final String title;

  /// The year the movie was released.
  final String year;

  /// The date the movie was added.
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime? added;

  /// The ID of the category the movie belongs to.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  final int? categoryId;

  /// The IDs of the categories the movie belongs to.
  @JsonKey(name: 'category_ids')
  final List<int>? categoryIds;

  /// The container extension of the movie.
  @JsonKey(name: 'container_extension')
  final String containerExtension;

  /// The custom SID of the movie.
  @JsonKey(name: 'custom_sid')
  final String? customSid;

  /// The direct source of the movie.
  @JsonKey(name: 'direct_source')
  final String directSource;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeMovieDataToJson(this);
}
