/// Server metadata from general information endpoint.
///
/// Date fields are normalized to UTC.
class ServerInfo {
  /// Creates server info.
  const ServerInfo({
    this.xui,
    this.version,
    this.revision,
    this.url,
    this.port,
    this.httpsPort,
    this.serverProtocol,
    this.rtmpPort,
    this.timestampNow,
    this.timeNow,
    this.timezone,
  });

  /// Whether server reports XUI mode.
  final bool? xui;

  /// Server version string.
  final String? version;

  /// Server revision number.
  final int? revision;

  /// Host/domain reported by server.
  final String? url;

  /// HTTP port.
  final int? port;

  /// HTTPS port.
  final int? httpsPort;

  /// Protocol label reported by server.
  final String? serverProtocol;

  /// RTMP port.
  final int? rtmpPort;

  /// Server timestamp in UTC.
  final DateTime? timestampNow;

  /// Server current time parsed to UTC.
  final DateTime? timeNow;

  /// Server timezone identifier/string.
  final String? timezone;
}
