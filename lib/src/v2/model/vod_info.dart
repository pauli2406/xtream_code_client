/// Full VOD details payload from `get_vod_info`.
class VodInfo {
  /// Creates full VOD info.
  const VodInfo({
    required this.info,
    required this.movieData,
  });

  /// Main details section.
  final VodDetails info;

  /// Movie stream metadata section.
  final MovieData movieData;
}

/// Main VOD details section.
///
/// Date fields are normalized to UTC.
class VodDetails {
  /// Creates VOD detail fields.
  const VodDetails({
    this.kinopoiskUrl,
    this.tmdbId,
    this.name,
    this.oName,
    this.coverBig,
    this.movieImage,
    this.releaseDate,
    this.episodeRunTime,
    this.youtubeTrailer,
    this.director,
    this.actors,
    this.cast,
    this.description,
    this.plot,
    this.age,
    this.mpaaRating,
    this.ratingCountKinopoisk,
    this.country,
    this.genre,
    this.backdropPath,
    this.durationSecs,
    this.duration,
    this.bitrate,
    this.rating,
    this.subtitles,
  });

  /// Kinopoisk URL.
  final String? kinopoiskUrl;

  /// TMDB identifier.
  final int? tmdbId;

  /// Display name.
  final String? name;

  /// Original name.
  final String? oName;

  /// High-resolution cover URL.
  final String? coverBig;

  /// Movie image URL.
  final String? movieImage;

  /// Release date in UTC.
  final DateTime? releaseDate;

  /// Runtime in minutes when available.
  final int? episodeRunTime;

  /// Trailer URL.
  final String? youtubeTrailer;

  /// Director names.
  final String? director;

  /// Actors string.
  final String? actors;

  /// Cast string.
  final String? cast;

  /// Description text.
  final String? description;

  /// Plot text.
  final String? plot;

  /// Age classification.
  final String? age;

  /// MPAA rating string.
  final String? mpaaRating;

  /// Kinopoisk rating count.
  final int? ratingCountKinopoisk;

  /// Country string.
  final String? country;

  /// Genre string.
  final String? genre;

  /// Backdrop image URLs.
  final List<String>? backdropPath;

  /// Duration in seconds.
  final int? durationSecs;

  /// Duration string representation.
  final String? duration;

  /// Bitrate value.
  final int? bitrate;

  /// Rating value.
  final double? rating;

  /// Subtitle paths/urls.
  final List<String>? subtitles;
}

/// VOD movie stream metadata section.
///
/// Date fields are normalized to UTC.
class MovieData {
  /// Creates movie metadata section.
  const MovieData({
    this.streamId,
    this.name,
    this.title,
    this.year,
    this.added,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  /// Stream identifier for playback URL generation.
  final int? streamId;

  /// Display name.
  final String? name;

  /// Alternative title field.
  final String? title;

  /// Release year string.
  final String? year;

  /// Added timestamp in UTC.
  final DateTime? added;

  /// Primary category id.
  final int? categoryId;

  /// Multi-category ids.
  final List<int>? categoryIds;

  /// Container extension for playback URL generation.
  final String? containerExtension;

  /// Optional custom SID.
  final String? customSid;

  /// Direct source URL.
  final String? directSource;
}
