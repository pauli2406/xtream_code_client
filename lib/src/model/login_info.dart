import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/model/server_info.dart';
import 'package:xtream_code_client/src/model/user_info.dart';

part 'login_info.g.dart';

@JsonSerializable()
class LoginInfo {
  LoginInfo({
    required this.userInfo,
    required this.serverInfo,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
  UserInfo? userInfo;
  ServerInfo? serverInfo;

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}
