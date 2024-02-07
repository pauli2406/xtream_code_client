// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vod_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VodInfo _$VodInfoFromJson(Map<String, dynamic> json) => VodInfo(
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      movie_data:
          MovieData.fromJson(json['movie_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VodInfoToJson(VodInfo instance) => <String, dynamic>{
      'info': instance.info,
      'movie_data': instance.movie_data,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      kinopoisk_url: json['kinopoisk_url'] as String,
      tmdb_id: json['tmdb_id'] as int,
      name: json['name'] as String,
      o_name: json['o_name'] as String,
      cover_big: json['cover_big'] as String,
      movie_image: json['movie_image'] as String,
      release_date: DateTime.parse(json['release_date'] as String),
      episode_run_time: json['episode_run_time'] as int,
      youtube_trailer: json['youtube_trailer'] as String,
      director: json['director'] as String,
      actors: json['actors'] as String,
      cast: json['cast'] as String,
      description: json['description'] as String,
      plot: json['plot'] as String,
      age: json['age'] as String,
      mpaa_rating: json['mpaa_rating'] as String,
      rating_count_kinopoisk: json['rating_count_kinopoisk'] as int,
      country: json['country'] as String,
      genre: json['genre'] as String,
      backdrop_path: (json['backdrop_path'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      duration_secs: json['duration_secs'] as int,
      duration: json['duration'] as String,
      bitrate: json['bitrate'] as int,
      rating: json['rating'] as int,
      releasedate: DateTime.parse(json['releasedate'] as String),
      subtitles: json['subtitles'] as List<dynamic>,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'kinopoisk_url': instance.kinopoisk_url,
      'tmdb_id': instance.tmdb_id,
      'name': instance.name,
      'o_name': instance.o_name,
      'cover_big': instance.cover_big,
      'movie_image': instance.movie_image,
      'release_date': instance.release_date.toIso8601String(),
      'episode_run_time': instance.episode_run_time,
      'youtube_trailer': instance.youtube_trailer,
      'director': instance.director,
      'actors': instance.actors,
      'cast': instance.cast,
      'description': instance.description,
      'plot': instance.plot,
      'age': instance.age,
      'mpaa_rating': instance.mpaa_rating,
      'rating_count_kinopoisk': instance.rating_count_kinopoisk,
      'country': instance.country,
      'genre': instance.genre,
      'backdrop_path': instance.backdrop_path,
      'duration_secs': instance.duration_secs,
      'duration': instance.duration,
      'bitrate': instance.bitrate,
      'rating': instance.rating,
      'releasedate': instance.releasedate.toIso8601String(),
      'subtitles': instance.subtitles,
    };

MovieData _$MovieDataFromJson(Map<String, dynamic> json) => MovieData(
      streamId: json['stream_id'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      added: dateTimeFromEpochSeconds(json['added'] as int),
      categoryId: json['categoryId'] as String,
      categoryIds:
          (json['categoryIds'] as List<dynamic>).map((e) => e as int).toList(),
      containerExtension: json['containerExtension'] as String,
      customSid: json['custom_sid'] as String,
      directSource: json['direct_source'] as String,
    );

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'stream_id': instance.streamId,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'added': instance.added.toIso8601String(),
      'categoryId': instance.categoryId,
      'categoryIds': instance.categoryIds,
      'containerExtension': instance.containerExtension,
      'custom_sid': instance.customSid,
      'direct_source': instance.directSource,
    };
