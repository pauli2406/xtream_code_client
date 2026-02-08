class ServerInfo {
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

  final bool? xui;
  final String? version;
  final int? revision;
  final String? url;
  final int? port;
  final int? httpsPort;
  final String? serverProtocol;
  final int? rtmpPort;
  final DateTime? timestampNow;
  final DateTime? timeNow;
  final String? timezone;
}
