// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeSeriesInfo _$XTremeCodeSeriesInfoFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeSeriesInfo(
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => XTremeCodeSeason.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: XTremeCodeInfo.fromJson(json['info'] as Map<String, dynamic>),
      episodes: (json['episodes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    XTremeCodeEpisode.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$XTremeCodeSeriesInfoToJson(
        XTremeCodeSeriesInfo instance) =>
    <String, dynamic>{
      'seasons': instance.seasons,
      'info': instance.info,
      'episodes': instance.episodes,
    };

XTremeCodeSeason _$XTremeCodeSeasonFromJson(Map<String, dynamic> json) =>
    XTremeCodeSeason(
      airDate: json['air_date'] as String,
      episodeCount: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      seasonNumber: json['season_number'] as int,
      voteAverage: json['vote_average'] as int,
      cover: json['cover'] as String,
      coverBig: json['cover_big'] as String,
    );

Map<String, dynamic> _$XTremeCodeSeasonToJson(XTremeCodeSeason instance) =>
    <String, dynamic>{
      'air_date': instance.airDate,
      'episode_count': instance.episodeCount,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'season_number': instance.seasonNumber,
      'vote_average': instance.voteAverage,
      'cover': instance.cover,
      'cover_big': instance.coverBig,
    };

XTremeCodeInfo _$XTremeCodeInfoFromJson(Map<String, dynamic> json) =>
    XTremeCodeInfo(
      name: json['name'] as String?,
      title: json['title'] as String?,
      year: json['year'] as String?,
      cover: json['cover'] as String?,
      plot: json['plot'] as String?,
      cast: json['cast'] as String?,
      director: json['director'] as String?,
      genre: json['genre'] as String?,
      releaseDate: json['releaseDate'] as String?,
      lastModified: dateTimeFromEpochSeconds(json['last_modified'] as String?),
      rating: dynamicToDoubleConverter(json['rating']),
      rating5based: dynamicToDoubleConverter(json['rating_5based']),
      backdropPath: (json['backdrop_path'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      youtubeTrailer: json['youtube_trailer'] as String?,
      episodeRunTime: dynamicToIntConverter(json['episode_run_time']),
      categoryId: dynamicToIntConverter(json['category_id']),
      categoryIds: (json['category_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$XTremeCodeInfoToJson(XTremeCodeInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'cover': instance.cover,
      'plot': instance.plot,
      'cast': instance.cast,
      'director': instance.director,
      'genre': instance.genre,
      'releaseDate': instance.releaseDate,
      'last_modified': instance.lastModified?.toIso8601String(),
      'rating': instance.rating,
      'rating_5based': instance.rating5based,
      'backdrop_path': instance.backdropPath,
      'youtube_trailer': instance.youtubeTrailer,
      'episode_run_time': instance.episodeRunTime,
      'category_id': instance.categoryId,
      'category_ids': instance.categoryIds,
    };

XTremeCodeEpisode _$XTremeCodeEpisodeFromJson(Map<String, dynamic> json) =>
    XTremeCodeEpisode(
      id: dynamicToIntConverter(json['id']),
      episodeNum: dynamicToIntConverter(json['episode_num']),
      title: json['title'] as String,
      containerExtension: json['container_extension'] as String,
      info:
          XTremeCodeEpisodeInfo.fromJson(json['info'] as Map<String, dynamic>),
      subtitles:
          (json['subtitles'] as List<dynamic>).map((e) => e as String).toList(),
      customSid: dynamicToIntConverter(json['custom_sid']),
      added: dateTimeFromEpochSeconds(json['added'] as String?),
      season: dynamicToIntConverter(json['season']),
      directSource: json['direct_source'] as String,
    );

Map<String, dynamic> _$XTremeCodeEpisodeToJson(XTremeCodeEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'episode_num': instance.episodeNum,
      'title': instance.title,
      'container_extension': instance.containerExtension,
      'info': instance.info,
      'subtitles': instance.subtitles,
      'custom_sid': instance.customSid,
      'added': instance.added?.toIso8601String(),
      'season': instance.season,
      'direct_source': instance.directSource,
    };

XTremeCodeEpisodeInfo _$XTremeCodeEpisodeInfoFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeEpisodeInfo(
      tmdbId: json['tmdb_id'] as int?,
      releaseDate: json['releaseDate'] as String?,
      plot: json['plot'] as String?,
      durationSecs: dynamicToIntConverter(json['duration_secs']),
      duration: json['duration'] as String?,
      movieImage: json['movie_image'] as String?,
      bitrate: json['bitrate'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      season: json['season'] as int?,
      coverBig: json['cover_big'] as String?,
    );

Map<String, dynamic> _$XTremeCodeEpisodeInfoToJson(
        XTremeCodeEpisodeInfo instance) =>
    <String, dynamic>{
      'tmdb_id': instance.tmdbId,
      'releaseDate': instance.releaseDate,
      'plot': instance.plot,
      'duration_secs': instance.durationSecs,
      'duration': instance.duration,
      'movie_image': instance.movieImage,
      'bitrate': instance.bitrate,
      'rating': instance.rating,
      'season': instance.season,
      'cover_big': instance.coverBig,
    };
