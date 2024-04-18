import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'user_info.g.dart';

/// Represents the user information in Xtream Code.
@JsonSerializable()
class XTremeCodeUserInfo {
  /// Creates a new instance of [XTremeCodeUserInfo].
  XTremeCodeUserInfo({
    required this.username,
    required this.password,
    required this.message,
    required this.auth,
    required this.status,
    required this.expDate,
    required this.isTrial,
    required this.activeCons,
    required this.createdAt,
    required this.maxConnections,
    required this.allowedOutputFormats,
  });

  /// Creates a new instance of [XTremeCodeUserInfo] from a JSON object.
  factory XTremeCodeUserInfo.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeUserInfoFromJson(json);

  /// The username of the user.
  String? username;

  /// The password of the user.
  String? password;

  /// The message for the user.
  String? message;

  /// The authentication status of the user.
  @JsonKey(name: 'auth', fromJson: dynamicToBool)
  bool? auth;

  /// The status of the user.
  String? status;

  /// The expiration date of the user's subscription.
  @JsonKey(name: 'exp_date', fromJson: dateTimeFromEpochSeconds)
  final DateTime? expDate;

  /// Whether the user is on a trial subscription.
  @JsonKey(name: 'is_trial', fromJson: dynamicToBool)
  bool? isTrial;

  /// The number of active connections of the user.
  @JsonKey(name: 'active_cons', fromJson: dynamicToIntConverter)
  int? activeCons;

  /// The date when the user was created.
  @JsonKey(name: 'created_at', fromJson: dateTimeFromEpochSeconds)
  final DateTime? createdAt;

  /// The maximum number of connections allowed for the user.
  @JsonKey(name: 'max_connections', fromJson: dynamicToIntConverter)
  int? maxConnections;

  /// The output formats allowed for the user.
  @JsonKey(name: 'allowed_output_formats')
  List<String> allowedOutputFormats;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeUserInfoToJson(this);
}
