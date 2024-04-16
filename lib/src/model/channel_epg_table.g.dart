// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_epg_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeChannelEpgTable _$XTremeCodeChannelEpgTableFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeChannelEpgTable(
      epgListings: (json['epg_listings'] as List<dynamic>)
          .map((e) =>
              XTremeCodeEpgListingTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$XTremeCodeChannelEpgTableToJson(
        XTremeCodeChannelEpgTable instance) =>
    <String, dynamic>{
      'epg_listings': instance.epgListings,
    };

XTremeCodeEpgListingTable _$XTremeCodeEpgListingTableFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeEpgListingTable(
      id: dynamicToIntConverter(json['id']),
      epgId: dynamicToIntConverter(json['epg_id']),
      title: json['title'] as String?,
      lang: json['lang'] as String?,
      start: dateTimeFromString(json['start'] as String?),
      end: dateTimeFromString(json['end'] as String?),
      description: json['description'] as String?,
      channelId: json['channel_id'] as String,
      startTimestamp:
          dateTimeFromEpochSeconds(json['start_timestamp'] as String?),
      stopTimestamp:
          dateTimeFromEpochSeconds(json['stop_timestamp'] as String?),
      nowPlaying: intToBool(json['now_playing'] as int),
      hasArchive: intToBool(json['has_archive'] as int),
    );

Map<String, dynamic> _$XTremeCodeEpgListingTableToJson(
        XTremeCodeEpgListingTable instance) =>
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
      'now_playing': instance.nowPlaying,
      'has_archive': instance.hasArchive,
    };
