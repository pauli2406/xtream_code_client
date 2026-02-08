class SeriesInfo {
  const SeriesInfo({
    required this.seasons,
    required this.info,
    required this.episodes,
  });

  final List<Season>? seasons;
  final SeriesDetails info;
  final Map<String, List<Episode>>? episodes;
}

class Season {
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

  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final int? seasonNumber;
  final double? voteAverage;
  final String? cover;
  final String? coverBig;
}

class SeriesDetails {
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

  final String? name;
  final String? title;
  final String? year;
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

class Episode {
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

  final int? id;
  final int? episodeNum;
  final String? title;
  final String? containerExtension;
  final EpisodeInfo info;
  final List<String>? subtitles;
  final String? customSid;
  final DateTime? added;
  final int? season;
  final String? directSource;
}

class EpisodeInfo {
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

  final int? tmdbId;
  final DateTime? releaseDate;
  final String? plot;
  final int? durationSecs;
  final String? duration;
  final String? movieImage;
  final int? bitrate;
  final double? rating;
  final int? season;
  final String? coverBig;
}
