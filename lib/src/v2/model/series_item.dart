/// Series list item from `get_series`.
///
/// Date fields are normalized to UTC.
class SeriesItem {
  /// Creates a series list item.
  const SeriesItem({
    this.num,
    this.name,
    this.title,
    this.year,
    this.streamType,
    this.seriesId,
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

  /// Provider-local ordering index.
  final int? num;

  /// Display name.
  final String? name;

  /// Alternative title field.
  final String? title;

  /// Release year string.
  final String? year;

  /// Stream type (typically `series`).
  final String? streamType;

  /// Series identifier used by `get_series_info`.
  final int? seriesId;

  /// Cover image URL.
  final String? cover;

  /// Series plot text.
  final String? plot;

  /// Cast list as provided by server.
  final String? cast;

  /// Director names.
  final String? director;

  /// Genre label string.
  final String? genre;

  /// Release date in UTC.
  final DateTime? releaseDate;

  /// Last-modified timestamp in UTC.
  final DateTime? lastModified;

  /// Rating value.
  final double? rating;

  /// 5-based rating value when provided.
  final double? rating5based;

  /// Backdrop image URLs.
  final List<String>? backdropPath;

  /// Trailer URL (often YouTube).
  final String? youtubeTrailer;

  /// Episode runtime in minutes when available.
  final int? episodeRunTime;

  /// Primary category id.
  final int? categoryId;

  /// Multi-category ids.
  final List<int>? categoryIds;
}
