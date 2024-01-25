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
                .toList(),),
      ),
    );

Map<String, dynamic> _$SeriesInfoToJson(SeriesInfo instance) =>
    <String, dynamic>{
      'seasons': instance.seasons,
      'info': instance.info,
      'episodes': instance.episodes,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      air_date: json['air_date'] as String,
      episode_count: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      season_number: json['season_number'] as int,
      vote_average: json['vote_average'] as int,
      cover: json['cover'] as String,
      cover_big: json['cover_big'] as String,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'air_date': instance.air_date,
      'episode_count': instance.episode_count,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'season_number': instance.season_number,
      'vote_average': instance.vote_average,
      'cover': instance.cover,
      'cover_big': instance.cover_big,
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
      release_date: DateTime.parse(json['release_date'] as String),
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      last_modified: dateTimeFromEpochSeconds(json['last_modified'] as int),
      rating: json['rating'] as String,
      rating_5based: (json['rating_5based'] as num).toDouble(),
      backdrop_path: (json['backdrop_path'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      youtube_trailer: json['youtube_trailer'] as String,
      episode_run_time: json['episode_run_time'] as String,
      category_id: json['category_id'] as String,
      category_ids:
          (json['category_ids'] as List<dynamic>).map((e) => e as int).toList(),
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
      'release_date': instance.release_date.toIso8601String(),
      'releaseDate': instance.releaseDate.toIso8601String(),
      'last_modified': instance.last_modified.toIso8601String(),
      'rating': instance.rating,
      'rating_5based': instance.rating_5based,
      'backdrop_path': instance.backdrop_path,
      'youtube_trailer': instance.youtube_trailer,
      'episode_run_time': instance.episode_run_time,
      'category_id': instance.category_id,
      'category_ids': instance.category_ids,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: json['id'] as String,
      episode_num: json['episode_num'] as String,
      title: json['title'] as String,
      container_extension: json['container_extension'] as String,
      info: EpisodeInfo.fromJson(json['info'] as Map<String, dynamic>),
      subtitles:
          (json['subtitles'] as List<dynamic>).map((e) => e as String).toList(),
      custom_sid: json['custom_sid'] as String,
      added: dateTimeFromEpochSeconds(json['added'] as int),
      season: json['season'] as int,
      direct_source: json['direct_source'] as String,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'episode_num': instance.episode_num,
      'title': instance.title,
      'container_extension': instance.container_extension,
      'info': instance.info,
      'subtitles': instance.subtitles,
      'custom_sid': instance.custom_sid,
      'added': instance.added.toIso8601String(),
      'season': instance.season,
      'direct_source': instance.direct_source,
    };

EpisodeInfo _$EpisodeInfoFromJson(Map<String, dynamic> json) => EpisodeInfo(
      tmdb_id: json['tmdb_id'] as int,
      release_date: DateTime.parse(json['release_date'] as String),
      plot: json['plot'] as String,
      duration_secs: json['duration_secs'] as int,
      duration: json['duration'] as String,
      movie_image: json['movie_image'] as String,
      bitrate: json['bitrate'] as int,
      rating: (json['rating'] as num).toDouble(),
      season: json['season'] as int,
      cover_big: json['cover_big'] as String,
    );

Map<String, dynamic> _$EpisodeInfoToJson(EpisodeInfo instance) =>
    <String, dynamic>{
      'tmdb_id': instance.tmdb_id,
      'release_date': instance.release_date.toIso8601String(),
      'plot': instance.plot,
      'duration_secs': instance.duration_secs,
      'duration': instance.duration,
      'movie_image': instance.movie_image,
      'bitrate': instance.bitrate,
      'rating': instance.rating,
      'season': instance.season,
      'cover_big': instance.cover_big,
    };
