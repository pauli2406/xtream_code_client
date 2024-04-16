// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vod_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeVodItem _$XTremeCodeVodItemFromJson(Map<String, dynamic> json) =>
    XTremeCodeVodItem(
      streamId: dynamicToIntConverter(json['stream_id']),
      num: dynamicToIntConverter(json['num']),
      name: json['name'] as String?,
      title: json['title'] as String?,
      year: json['year'] as String?,
      streamType: json['stream_type'] as String?,
      streamIcon: json['stream_icon'] as String?,
      rating: dynamicToDoubleConverter(json['rating']),
      rating5based: dynamicToDoubleConverter(json['rating_5based']),
      added: dateTimeFromEpochSeconds(json['added'] as String?),
      categoryId: dynamicToIntConverter(json['category_id']),
      categoryIds:
          (json['category_ids'] as List<dynamic>).map((e) => e as int).toList(),
      containerExtension: json['container_extension'] as String?,
      customSid: dynamicToIntConverter(json['custom_sid']),
      directSource: json['direct_source'] as String?,
    );

Map<String, dynamic> _$XTremeCodeVodItemToJson(XTremeCodeVodItem instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'title': instance.title,
      'year': instance.year,
      'stream_type': instance.streamType,
      'stream_id': instance.streamId,
      'stream_icon': instance.streamIcon,
      'rating': instance.rating,
      'rating_5based': instance.rating5based,
      'added': instance.added?.toIso8601String(),
      'category_id': instance.categoryId,
      'category_ids': instance.categoryIds,
      'container_extension': instance.containerExtension,
      'custom_sid': instance.customSid,
      'direct_source': instance.directSource,
    };
