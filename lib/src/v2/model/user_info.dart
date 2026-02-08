class UserInfo {
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

  final String? username;
  final String? password;
  final String? message;
  final bool? auth;
  final String? status;
  final DateTime? expDate;
  final bool? isTrial;
  final int? activeCons;
  final DateTime? createdAt;
  final int? maxConnections;
  final List<String>? allowedOutputFormats;
}
