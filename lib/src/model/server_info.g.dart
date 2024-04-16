// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeServerInfo _$XTremeCodeServerInfoFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeServerInfo(
      xui: json['xui'] as bool?,
      version: json['version'] as String?,
      revision: dynamicToIntConverter(json['revision']),
      url: json['url'] as String?,
      port: json['port'] as String?,
      httpsPort: json['https_port'] as String?,
      serverProtocol: json['server_protocol'] as String?,
      rtmpPort: json['rtmp_port'] as String?,
      timestampNow: dateTimeFromEpochSecondsInt(json['timestamp_now'] as int?),
      timeNow: dateTimeFromString(json['time_now'] as String?),
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$XTremeCodeServerInfoToJson(
        XTremeCodeServerInfo instance) =>
    <String, dynamic>{
      'xui': instance.xui,
      'version': instance.version,
      'revision': instance.revision,
      'url': instance.url,
      'port': instance.port,
      'https_port': instance.httpsPort,
      'server_protocol': instance.serverProtocol,
      'rtmp_port': instance.rtmpPort,
      'timestamp_now': instance.timestampNow?.toIso8601String(),
      'time_now': instance.timeNow?.toIso8601String(),
      'timezone': instance.timezone,
    };
