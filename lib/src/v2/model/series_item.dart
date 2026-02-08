class SeriesItem {
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

  final int? num;
  final String? name;
  final String? title;
  final String? year;
  final String? streamType;
  final int? seriesId;
  final String? cover;
  final String? plot;
  final String? cast;
  final String? director;
  final String? genre;
  final DateTime? releaseDate;
  final DateTime? lastModified;
  final double? rating;
  final double? rating5based;
  final List<String>? backdropPath;
  final String? youtubeTrailer;
  final int? episodeRunTime;
  final int? categoryId;
  final List<int>? categoryIds;
}
