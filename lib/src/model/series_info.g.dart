// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesInfo _$SeriesInfoFromJson(Map<String, dynamic> json) => SeriesInfo(
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      episodes: (json['episodes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Episode.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$SeriesInfoToJson(SeriesInfo instance) =>
    <String, dynamic>{
      'seasons': instance.seasons,
      'info': instance.info,
      'episodes': instance.episodes,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
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

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
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

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      name: json['name'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      cover: json['cover'] as String,
      plot: json['plot'] as String,
      cast: json['cast'] as String,
      director: json['director'] as String,
      genre: json['genre'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      lastModified: dateTimeFromEpochSeconds(json['last_modified'] as int),
      rating: json['rating'] as String,
      rating5based: (json['rating_5based'] as num).toDouble(),
      backdropPath: (json['backdrop_path'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      youtubeTrailer: json['youtube_trailer'] as String,
      episodeRunTime: json['episode_run_time'] as String,
      categoryId: json['category_id'] as String,
      categoryIds:
          (json['categoryIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'cover': instance.cover,
      'plot': instance.plot,
      'cast': instance.cast,
      'director': instance.director,
      'genre': instance.genre,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'last_modified': instance.lastModified.toIso8601String(),
      'rating': instance.rating,
      'rating_5based': instance.rating5based,
      'backdrop_path': instance.backdropPath,
      'youtube_trailer': instance.youtubeTrailer,
      'episode_run_time': instance.episodeRunTime,
      'category_id': instance.categoryId,
      'categoryIds': instance.categoryIds,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: json['id'] as String,
      episodeNum: json['episode_num'] as String,
      title: json['title'] as String,
      containerExtension: json['container_extension'] as String,
      info: EpisodeInfo.fromJson(json['info'] as Map<String, dynamic>),
      subtitles:
          (json['subtitles'] as List<dynamic>).map((e) => e as String).toList(),
      customSid: json['custom_sid'] as String,
      added: dateTimeFromEpochSeconds(json['added'] as int),
      season: json['season'] as int,
      directSource: json['direct_source'] as String,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'episode_num': instance.episodeNum,
      'title': instance.title,
      'container_extension': instance.containerExtension,
      'info': instance.info,
      'subtitles': instance.subtitles,
      'custom_sid': instance.customSid,
      'added': instance.added.toIso8601String(),
      'season': instance.season,
      'direct_source': instance.directSource,
    };

EpisodeInfo _$EpisodeInfoFromJson(Map<String, dynamic> json) => EpisodeInfo(
      tmdbId: json['tmdb_id'] as int,
      releaseDate: DateTime.parse(json['release_date'] as String),
      plot: json['plot'] as String,
      durationSecs: json['duration_secs'] as int,
      duration: json['duration'] as String,
      movieImage: json['movie_image'] as String,
      bitrate: json['bitrate'] as int,
      rating: (json['rating'] as num).toDouble(),
      season: json['season'] as int,
      coverBig: json['cover_big'] as String,
    );

Map<String, dynamic> _$EpisodeInfoToJson(EpisodeInfo instance) =>
    <String, dynamic>{
      'tmdb_id': instance.tmdbId,
      'release_date': instance.releaseDate.toIso8601String(),
      'plot': instance.plot,
      'duration_secs': instance.durationSecs,
      'duration': instance.duration,
      'movie_image': instance.movieImage,
      'bitrate': instance.bitrate,
      'rating': instance.rating,
      'season': instance.season,
      'cover_big': instance.coverBig,
    };
