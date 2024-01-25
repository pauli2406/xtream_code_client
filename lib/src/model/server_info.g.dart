// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo(
      xui: json['xui'] as bool?,
      version: json['version'] as String?,
      revision: json['revision'] as int?,
      url: json['url'] as String?,
      port: json['port'] as String?,
      httpsPort: json['httpsPort'] as String?,
      serverProtocol: json['serverProtocol'] as String?,
      rtmpPort: json['rtmpPort'] as String?,
      timestampNow: dateTimeFromEpochSeconds(json['timestampNow'] as int),
      timeNow: dateTimeFromString(json['timeNow'] as String),
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'xui': instance.xui,
      'version': instance.version,
      'revision': instance.revision,
      'url': instance.url,
      'port': instance.port,
      'httpsPort': instance.httpsPort,
      'serverProtocol': instance.serverProtocol,
      'rtmpPort': instance.rtmpPort,
      'timestampNow': instance.timestampNow.toIso8601String(),
      'timeNow': instance.timeNow.toIso8601String(),
      'timezone': instance.timezone,
    };
