// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_epg_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelEpgTable _$ChannelEpgTableFromJson(Map<String, dynamic> json) =>
    ChannelEpgTable(
      epg_listings: (json['epg_listings'] as List<dynamic>)
          .map((e) => EpgListing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelEpgTableToJson(ChannelEpgTable instance) =>
    <String, dynamic>{
      'epg_listings': instance.epg_listings,
    };

EpgListing _$EpgListingFromJson(Map<String, dynamic> json) => EpgListing(
      id: json['id'] as String,
      epg_id: json['epg_id'] as String,
      title: json['title'] as String,
      lang: json['lang'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      description: json['description'] as String,
      channel_id: json['channel_id'] as String,
      start_timestamp: dateTimeFromEpochSeconds(json['start_timestamp'] as int),
      stop_timestamp: dateTimeFromEpochSeconds(json['stop_timestamp'] as int),
      now_playing: intToBool(json['now_playing'] as int),
      has_archive: intToBool(json['has_archive'] as int),
    );

Map<String, dynamic> _$EpgListingToJson(EpgListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'epg_id': instance.epg_id,
      'title': instance.title,
      'lang': instance.lang,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'description': instance.description,
      'channel_id': instance.channel_id,
      'start_timestamp': instance.start_timestamp.toIso8601String(),
      'stop_timestamp': instance.stop_timestamp.toIso8601String(),
      'now_playing': instance.now_playing,
      'has_archive': instance.has_archive,
    };
