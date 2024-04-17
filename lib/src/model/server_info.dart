import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'server_info.g.dart';

/// Represents the server information in Xtream Code.
@JsonSerializable()
class XTremeCodeServerInfo {
  /// Creates a new instance of [XTremeCodeServerInfo].
  XTremeCodeServerInfo({
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

  /// Creates a new instance of [XTremeCodeServerInfo] from a JSON object.
  factory XTremeCodeServerInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeServerInfoFromJson(json);

  /// The XUI of the server.
  @JsonKey(fromJson: dynamicToBool)
  bool? xui;

  /// The version of the server.
  String? version;

  /// The revision of the server.
  @JsonKey(fromJson: dynamicToIntConverter)
  int? revision;

  /// The URL of the server.
  String? url;

  /// The port of the server.
  @JsonKey(fromJson: dynamicToIntConverter)
  int? port;

  /// The HTTPS port of the server.
  @JsonKey(name: 'https_port', fromJson: dynamicToIntConverter)
  int? httpsPort;

  /// The protocol of the server.
  @JsonKey(name: 'server_protocol')
  String? serverProtocol;

  /// The RTMP port of the server.
  @JsonKey(name: 'rtmp_port', fromJson: dynamicToIntConverter)
  int? rtmpPort;

  /// The current timestamp of the server.
  @JsonKey(name: 'timestamp_now', fromJson: dateTimeFromEpochSeconds)
  DateTime? timestampNow;

  /// The current time of the server.
  @JsonKey(name: 'time_now', fromJson: dateTimeFromString)
  DateTime? timeNow;

  /// The timezone of the server.
  String? timezone;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeServerInfoToJson(this);
}
