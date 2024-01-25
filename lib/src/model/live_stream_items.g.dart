// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamItems _$LiveStreamItemsFromJson(Map<String, dynamic> json) =>
    LiveStreamItems(
      liveStreamItems: (json['liveStreamItems'] as List<dynamic>)
          .map((e) => LiveStreamItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LiveStreamItemsToJson(LiveStreamItems instance) =>
    <String, dynamic>{
      'liveStreamItems': instance.liveStreamItems,
    };

LiveStreamItem _$LiveStreamItemFromJson(Map<String, dynamic> json) =>
    LiveStreamItem(
      num: json['num'] as int,
      name: json['name'] as String,
      stream_type: json['stream_type'] as String,
      stream_id: json['stream_id'] as int,
      stream_icon: json['stream_icon'] as String,
      epg_channel_id: json['epg_channel_id'] as String,
      added: dateTimeFromEpochSeconds(json['added'] as int),
      custom_sid: json['custom_sid'] as String,
      tv_archive: json['tv_archive'] as int,
      direct_source: json['direct_source'] as String,
      tv_archive_duration: json['tv_archive_duration'] as int,
      category_id: json['category_id'] as String,
      category_ids:
          (json['category_ids'] as List<dynamic>).map((e) => e as int).toList(),
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$LiveStreamItemToJson(LiveStreamItem instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'stream_type': instance.stream_type,
      'stream_id': instance.stream_id,
      'stream_icon': instance.stream_icon,
      'epg_channel_id': instance.epg_channel_id,
      'added': instance.added.toIso8601String(),
      'custom_sid': instance.custom_sid,
      'tv_archive': instance.tv_archive,
      'direct_source': instance.direct_source,
      'tv_archive_duration': instance.tv_archive_duration,
      'category_id': instance.category_id,
      'category_ids': instance.category_ids,
      'thumbnail': instance.thumbnail,
    };
