/// User/account metadata from general information endpoint.
///
/// Date fields are normalized to UTC.
class UserInfo {
  /// Creates user info.
  const UserInfo({
    this.username,
    this.password,
    this.message,
    this.auth,
    this.status,
    this.expDate,
    this.isTrial,
    this.activeCons,
    this.createdAt,
    this.maxConnections,
    this.allowedOutputFormats,
  });

  /// Account username.
  final String? username;

  /// Account password as reported by server.
  final String? password;

  /// Optional provider message.
  final String? message;

  /// Authentication flag.
  final bool? auth;

  /// Account status string.
  final String? status;

  /// Subscription expiration date in UTC.
  final DateTime? expDate;

  /// Trial-account flag.
  final bool? isTrial;

  /// Active connections currently in use.
  final int? activeCons;

  /// Account creation timestamp in UTC.
  final DateTime? createdAt;

  /// Maximum concurrent connections allowed.
  final int? maxConnections;

  /// Allowed stream output formats (for example `ts`, `m3u8`).
  final List<String>? allowedOutputFormats;
}
