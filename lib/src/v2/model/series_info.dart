/// Full series details payload from `get_series_info`.
class SeriesInfo {
  /// Creates series info payload.
  const SeriesInfo({
    required this.seasons,
    required this.info,
    required this.episodes,
  });

  /// Season metadata list.
  final List<Season>? seasons;

  /// Top-level series details.
  final SeriesDetails info;

  /// Episodes keyed by season number/string.
  final Map<String, List<Episode>>? episodes;
}

/// Season metadata.
///
/// Date fields are normalized to UTC.
class Season {
  /// Creates season metadata.
  const Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.seasonNumber,
    this.voteAverage,
    this.cover,
    this.coverBig,
  });

  /// Season first-air date in UTC.
  final DateTime? airDate;

  /// Number of episodes in this season.
  final int? episodeCount;

  /// Season identifier.
  final int? id;

  /// Season name.
  final String? name;

  /// Season overview text.
  final String? overview;

  /// Numeric season number.
  final int? seasonNumber;

  /// Average vote score.
  final double? voteAverage;

  /// Cover image URL.
  final String? cover;

  /// High-resolution cover URL.
  final String? coverBig;
}

/// Main series details section.
///
/// Date fields are normalized to UTC.
class SeriesDetails {
  /// Creates main series details.
  const SeriesDetails({
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
    this.backdropPath,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds,
  });

  /// Display name.
  final String? name;

  /// Alternative title field.
  final String? title;

  /// Release year string.
  final String? year;

  /// Cover image URL.
  final String? cover;

  /// Plot text.
  final String? plot;

  /// Cast list string.
  final String? cast;

  /// Director names.
  final String? director;

  /// Genre labels.
  final String? genre;

  /// Release date in UTC.
  final DateTime? releaseDate;

  /// Last-modified timestamp in UTC.
  final DateTime? lastModified;

  /// Rating value.
  final double? rating;

  /// 5-based rating value.
  final double? rating5based;

  /// Backdrop image URLs.
  final List<String>? backdropPath;

  /// Trailer URL.
  final String? youtubeTrailer;

  /// Episode runtime in minutes when available.
  final int? episodeRunTime;

  /// Primary category id.
  final int? categoryId;

  /// Multi-category ids.
  final List<int>? categoryIds;
}

/// Episode metadata entry.
///
/// Date fields are normalized to UTC.
class Episode {
  /// Creates episode metadata.
  const Episode({
    this.id,
    this.episodeNum,
    this.title,
    this.containerExtension,
    required this.info,
    this.subtitles,
    this.customSid,
    this.added,
    this.season,
    this.directSource,
  });

  /// Episode id.
  final int? id;

  /// Episode number in season.
  final int? episodeNum;

  /// Episode title.
  final String? title;

  /// Container extension for playback URL generation.
  final String? containerExtension;

  /// Nested episode details.
  final EpisodeInfo info;

  /// Subtitle paths/urls.
  final List<String>? subtitles;

  /// Optional custom SID.
  final String? customSid;

  /// Added timestamp in UTC.
  final DateTime? added;

  /// Season number.
  final int? season;

  /// Direct source URL.
  final String? directSource;
}

/// Nested episode details section.
///
/// Date fields are normalized to UTC.
class EpisodeInfo {
  /// Creates nested episode details.
  const EpisodeInfo({
    this.tmdbId,
    this.releaseDate,
    this.plot,
    this.durationSecs,
    this.duration,
    this.movieImage,
    this.bitrate,
    this.rating,
    this.season,
    this.coverBig,
  });

  /// TMDB identifier.
  final int? tmdbId;

  /// Release date in UTC.
  final DateTime? releaseDate;

  /// Plot text.
  final String? plot;

  /// Duration in seconds.
  final int? durationSecs;

  /// Duration string representation.
  final String? duration;

  /// Episode image URL.
  final String? movieImage;

  /// Bitrate value.
  final int? bitrate;

  /// Rating value.
  final double? rating;

  /// Season number.
  final int? season;

  /// High-resolution cover URL.
  final String? coverBig;
}
