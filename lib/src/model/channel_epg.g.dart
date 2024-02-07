// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_epg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelEpg _$ChannelEpgFromJson(Map<String, dynamic> json) => ChannelEpg(
      epg_listings: (json['epg_listings'] as List<dynamic>)
          .map((e) => EpgListing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelEpgToJson(ChannelEpg instance) =>
    <String, dynamic>{
      'epg_listings': instance.epg_listings,
    };

EpgListing _$EpgListingFromJson(Map<String, dynamic> json) => EpgListing(
      id: json['id'] as String,
      epgId: json['epg_id'] as String,
      title: json['title'] as String,
      lang: json['lang'] as String,
      start: DateTime.parse(json['start'] as String),
      end: dateTimeFromEpochSeconds(json['end'] as int),
      description: json['description'] as String,
      channelId: json['channel_id'] as String,
      startTimestamp: dateTimeFromEpochSeconds(json['start_timestamp'] as int),
      stopTimestamp: dateTimeFromEpochSeconds(json['stop_timestamp'] as int),
      stop: DateTime.parse(json['stop'] as String),
    );

Map<String, dynamic> _$EpgListingToJson(EpgListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'epg_id': instance.epgId,
      'title': instance.title,
      'lang': instance.lang,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'description': instance.description,
      'channel_id': instance.channelId,
      'start_timestamp': instance.startTimestamp.toIso8601String(),
      'stop_timestamp': instance.stopTimestamp.toIso8601String(),
      'stop': instance.stop.toIso8601String(),
    };
