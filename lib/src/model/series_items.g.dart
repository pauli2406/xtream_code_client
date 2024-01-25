// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesItems _$SeriesItemsFromJson(Map<String, dynamic> json) => SeriesItems(
      seriesItems: (json['seriesItems'] as List<dynamic>)
          .map((e) => SeriesItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesItemsToJson(SeriesItems instance) =>
    <String, dynamic>{
      'seriesItems': instance.seriesItems,
    };

SeriesItem _$SeriesItemFromJson(Map<String, dynamic> json) => SeriesItem(
      num: json['num'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      stream_type: json['stream_type'] as String,
      series_id: json['series_id'] as int,
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

Map<String, dynamic> _$SeriesItemToJson(SeriesItem instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'stream_type': instance.stream_type,
      'series_id': instance.series_id,
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
