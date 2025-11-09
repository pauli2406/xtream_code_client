// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeServerInfo _$XTremeCodeServerInfoFromJson(
  Map<String, dynamic> json,
) => XTremeCodeServerInfo(
  xui: dynamicToBool(json['xui']),
  version: json['version'] as String?,
  revision: dynamicToIntConverter(json['revision']),
  url: json['url'] as String?,
  port: dynamicToIntConverter(json['port']),
  httpsPort: dynamicToIntConverter(json['https_port']),
  serverProtocol: json['server_protocol'] as String?,
  rtmpPort: dynamicToIntConverter(json['rtmp_port']),
  timestampNow: dateTimeFromEpochSeconds(json['timestamp_now']),
  timeNow: dateTimeFromString(json['time_now']),
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$XTremeCodeServerInfoToJson(
  XTremeCodeServerInfo instance,
) => <String, dynamic>{
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
