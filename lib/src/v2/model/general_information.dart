import 'package:xtream_code_client/src/v2/model/server_info.dart';
import 'package:xtream_code_client/src/v2/model/user_info.dart';

class GeneralInformation {
  const GeneralInformation({
    required this.userInfo,
    required this.serverInfo,
  });

  final UserInfo userInfo;
  final ServerInfo serverInfo;
}
