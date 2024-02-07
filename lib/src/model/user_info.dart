import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({
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

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  String? username;
  String? password;
  String? message;
  int? auth;
  String? status;
  @JsonKey(name: 'exp_date', fromJson: dateTimeFromEpochSeconds)
  final DateTime expDate;
  @JsonKey(name: 'is_trial')
  String? isTrial;
  @JsonKey(name: 'active_cons')
  String? activeCons;
  @JsonKey(name: 'created_at', fromJson: dateTimeFromEpochSeconds)
  final DateTime createdAt;
  @JsonKey(name: 'max_connections')
  String? maxConnections;
  @JsonKey(name: 'allowed_output_formats')
  List<String>? allowedOutputFormats;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
