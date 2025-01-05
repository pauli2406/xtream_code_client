// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vod_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeVodInfo _$XTremeCodeVodInfoFromJson(Map<String, dynamic> json) =>
    XTremeCodeVodInfo(
      info: XTremeCodeInfoVod.fromJson(json['info'] as Map<String, dynamic>),
      movieData: XTremeCodeMovieData.fromJson(
          json['movie_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$XTremeCodeVodInfoToJson(XTremeCodeVodInfo instance) =>
    <String, dynamic>{
      'info': instance.info,
      'movie_data': instance.movieData,
    };

XTremeCodeInfoVod _$XTremeCodeInfoVodFromJson(Map<String, dynamic> json) =>
    XTremeCodeInfoVod(
      kinopoiskUrl: json['kinopoisk_url'] as String?,
      tmdbId: dynamicToIntConverter(json['tmdb_id']),
      name: json['name'] as String?,
      oName: json['o_name'] as String?,
      coverBig: json['cover_big'] as String?,
      movieImage: json['movie_image'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      episodeRunTime: dynamicToIntConverter(json['episode_run_time']),
      youtubeTrailer: json['youtube_trailer'] as String?,
      director: json['director'] as String?,
      actors: json['actors'] as String?,
      cast: json['cast'] as String?,
      description: json['description'] as String?,
      plot: json['plot'] as String?,
      age: json['age'] as String?,
      mpaaRating: json['mpaa_rating'] as String?,
      ratingCountKinopoisk:
          dynamicToIntConverter(json['rating_count_kinopoisk']),
      country: json['country'] as String?,
      genre: json['genre'] as String?,
      backdropPath: (json['backdrop_path'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      durationSecs: dynamicToIntConverter(json['duration_secs']),
      duration: json['duration'] as String?,
      bitrate: dynamicToIntConverter(json['bitrate']),
      rating: dynamicToDoubleConverter(json['rating']),
      releasedate: json['releasedate'] == null
          ? null
          : DateTime.parse(json['releasedate'] as String),
      subtitles: json['subtitles'] as List<dynamic>?,
    );

Map<String, dynamic> _$XTremeCodeInfoVodToJson(XTremeCodeInfoVod instance) =>
    <String, dynamic>{
      'kinopoisk_url': instance.kinopoiskUrl,
      'tmdb_id': instance.tmdbId,
      'name': instance.name,
      'o_name': instance.oName,
      'cover_big': instance.coverBig,
      'movie_image': instance.movieImage,
      'release_date': instance.releaseDate?.toIso8601String(),
      'episode_run_time': instance.episodeRunTime,
      'youtube_trailer': instance.youtubeTrailer,
      'director': instance.director,
      'actors': instance.actors,
      'cast': instance.cast,
      'description': instance.description,
      'plot': instance.plot,
      'age': instance.age,
      'mpaa_rating': instance.mpaaRating,
      'rating_count_kinopoisk': instance.ratingCountKinopoisk,
      'country': instance.country,
      'genre': instance.genre,
      'backdrop_path': instance.backdropPath,
      'duration_secs': instance.durationSecs,
      'duration': instance.duration,
      'bitrate': instance.bitrate,
      'rating': instance.rating,
      'releasedate': instance.releasedate?.toIso8601String(),
      'subtitles': instance.subtitles,
    };

XTremeCodeMovieData _$XTremeCodeMovieDataFromJson(Map<String, dynamic> json) =>
    XTremeCodeMovieData(
      streamId: dynamicToIntConverter(json['stream_id']),
      name: json['name'] as String?,
      title: json['title'] as String?,
      year: json['year'] as String?,
      added: dateTimeFromEpochSeconds(json['added']),
      categoryId: dynamicToIntConverter(json['category_id']),
      categoryIds: (json['category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      containerExtension: json['container_extension'] as String,
      customSid: json['custom_sid'] as String?,
      directSource: json['direct_source'] as String?,
    );

Map<String, dynamic> _$XTremeCodeMovieDataToJson(
        XTremeCodeMovieData instance) =>
    <String, dynamic>{
      'stream_id': instance.streamId,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'added': instance.added?.toIso8601String(),
      'category_id': instance.categoryId,
      'category_ids': instance.categoryIds,
      'container_extension': instance.containerExtension,
      'custom_sid': instance.customSid,
      'direct_source': instance.directSource,
    };
