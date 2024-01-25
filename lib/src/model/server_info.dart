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
  String? httpsPort;
  String? serverProtocol;
  String? rtmpPort;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  DateTime timestampNow;
  @JsonKey(fromJson: dateTimeFromString)
  DateTime timeNow;
  String? timezone;

  Map<String, dynamic> toJson() => _$ServerInfoToJson(this);
}
