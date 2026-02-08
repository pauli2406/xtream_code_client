import 'package:xtream_code_client/src/v2/model/server_info.dart';
import 'package:xtream_code_client/src/v2/model/user_info.dart';

/// Combined account and server information payload.
class GeneralInformation {
  /// Creates general information.
  const GeneralInformation({
    required this.userInfo,
    required this.serverInfo,
  });

  /// User/account data.
  final UserInfo userInfo;

  /// Server metadata.
  final ServerInfo serverInfo;
}
