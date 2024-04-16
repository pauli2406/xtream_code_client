// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_epg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeChannelEpg _$XTremeCodeChannelEpgFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeChannelEpg(
      epgListings: (json['epg_listings'] as List<dynamic>)
          .map((e) => XTremeCodeEpgListing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$XTremeCodeChannelEpgToJson(
        XTremeCodeChannelEpg instance) =>
    <String, dynamic>{
      'epg_listings': instance.epgListings,
    };

XTremeCodeEpgListing _$XTremeCodeEpgListingFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeEpgListing(
      id: dynamicToIntConverter(json['id']),
      epgId: dynamicToIntConverter(json['epg_id']),
      title: json['title'] as String?,
      lang: json['lang'] as String?,
      start: dateTimeFromString(json['start'] as String?),
      end: dateTimeFromEpochSeconds(json['end'] as String?),
      description: json['description'] as String?,
      channelId: json['channel_id'] as String?,
      startTimestamp:
          dateTimeFromEpochSeconds(json['start_timestamp'] as String?),
      stopTimestamp:
          dateTimeFromEpochSeconds(json['stop_timestamp'] as String?),
      stop:
          json['stop'] == null ? null : DateTime.parse(json['stop'] as String),
    );

Map<String, dynamic> _$XTremeCodeEpgListingToJson(
        XTremeCodeEpgListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'epg_id': instance.epgId,
      'title': instance.title,
      'lang': instance.lang,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'description': instance.description,
      'channel_id': instance.channelId,
      'start_timestamp': instance.startTimestamp?.toIso8601String(),
      'stop_timestamp': instance.stopTimestamp?.toIso8601String(),
      'stop': instance.stop?.toIso8601String(),
    };
