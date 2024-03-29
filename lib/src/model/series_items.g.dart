// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeSeriesItem _$XTremeCodeSeriesItemFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeSeriesItem(
      num: json['num'] as int?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      year: json['year'] as String?,
      streamType: json['stream_type'] as String?,
      seriesId: json['series_id'] as int,
      cover: json['cover'] as String?,
      plot: json['plot'] as String?,
      cast: json['cast'] as String?,
      director: json['director'] as String?,
      genre: json['genre'] as String?,
      releaseDate: json['releaseDate'] as String?,
      lastModified: dateTimeFromEpochSeconds(json['last_modified'] as String?),
      rating: json['rating'] as String?,
      rating5based: (json['rating_5based'] as num?)?.toDouble(),
      backdropPath: (json['backdrop_path'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      youtubeTrailer: json['youtube_trailer'] as String?,
      episodeRunTime: json['episode_run_time'] as String?,
      categoryId: json['category_id'] as String?,
      categoryIds:
          (json['category_ids'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$XTremeCodeSeriesItemToJson(
        XTremeCodeSeriesItem instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'stream_type': instance.streamType,
      'series_id': instance.seriesId,
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
