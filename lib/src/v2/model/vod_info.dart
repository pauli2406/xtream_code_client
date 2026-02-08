class VodInfo {
  const VodInfo({
    required this.info,
    required this.movieData,
  });

  final VodDetails info;
  final MovieData movieData;
}

class VodDetails {
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

  final String? kinopoiskUrl;
  final int? tmdbId;
  final String? name;
  final String? oName;
  final String? coverBig;
  final String? movieImage;
  final DateTime? releaseDate;
  final int? episodeRunTime;
  final String? youtubeTrailer;
  final String? director;
  final String? actors;
  final String? cast;
  final String? description;
  final String? plot;
  final String? age;
  final String? mpaaRating;
  final int? ratingCountKinopoisk;
  final String? country;
  final String? genre;
  final List<String>? backdropPath;
  final int? durationSecs;
  final String? duration;
  final int? bitrate;
  final double? rating;
  final List<String>? subtitles;
}

class MovieData {
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

  final int? streamId;
  final String? name;
  final String? title;
  final String? year;
  final DateTime? added;
  final int? categoryId;
  final List<int>? categoryIds;
  final String? containerExtension;
  final String? customSid;
  final String? directSource;
}
