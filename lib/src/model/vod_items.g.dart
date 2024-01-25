// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vod_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VodItems _$VodItemsFromJson(Map<String, dynamic> json) => VodItems(
      vodItems: (json['vodItems'] as List<dynamic>)
          .map((e) => VodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VodItemsToJson(VodItems instance) => <String, dynamic>{
      'vodItems': instance.vodItems,
    };

VodItem _$VodItemFromJson(Map<String, dynamic> json) => VodItem(
      num: json['num'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      stream_type: json['stream_type'] as String,
      stream_id: json['stream_id'] as int,
      stream_icon: json['stream_icon'] as String,
      rating: json['rating'] as int,
      rating_5based: json['rating_5based'] as int,
      added: dateTimeFromEpochSeconds(json['added'] as int),
      category_id: json['category_id'] as String,
      category_ids:
          (json['category_ids'] as List<dynamic>).map((e) => e as int).toList(),
      container_extension: json['container_extension'] as String,
      custom_sid: json['custom_sid'] as String,
      direct_source: json['direct_source'] as String,
    );

Map<String, dynamic> _$VodItemToJson(VodItem instance) => <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'stream_type': instance.stream_type,
      'stream_id': instance.stream_id,
      'stream_icon': instance.stream_icon,
      'rating': instance.rating,
      'rating_5based': instance.rating_5based,
      'added': instance.added.toIso8601String(),
      'category_id': instance.category_id,
      'category_ids': instance.category_ids,
      'container_extension': instance.container_extension,
      'custom_sid': instance.custom_sid,
      'direct_source': instance.direct_source,
    };
