import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'server_info.g.dart';

@JsonSerializable()
class ServerInfo {
  ServerInfo({
    required this.xui,
    required this.version,
    required this.revision,
    required this.url,
    required this.port,
    required this.httpsPort,
    required this.serverProtocol,
    required this.rtmpPort,
    required this.timestampNow,
    required this.timeNow,
    required this.timezone,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) =>
      _$ServerInfoFromJson(json);
  bool? xui;
  String? version;
  int? revision;
  String? url;
  String? port;
  @JsonKey(name: 'https_port')
  String? httpsPort;
  @JsonKey(name: 'server_protocol')
  String? serverProtocol;
  @JsonKey(name: 'rtmp_port')
  String? rtmpPort;
  @JsonKey(name: 'timestamp_now', fromJson: dateTimeFromEpochSeconds)
  DateTime timestampNow;
  @JsonKey(name: 'time_now', fromJson: dateTimeFromString)
  DateTime timeNow;
  String? timezone;

  Map<String, dynamic> toJson() => _$ServerInfoToJson(this);
}
