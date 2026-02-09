import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/general_information.dart';
import 'package:xtream_code_client/src/v2/model/server_info.dart';
import 'package:xtream_code_client/src/v2/model/user_info.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

class GeneralInformationMapper {
  static GeneralInformation fromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final user = _userInfo(
      ResponseNormalizer.readObjectField(json, 'user_info', context, jsonPath),
      context,
      '$jsonPath.user_info',
    );
    final server = _serverInfo(
      ResponseNormalizer.readObjectField(
          json, 'server_info', context, jsonPath),
      context,
      '$jsonPath.server_info',
    );

    return GeneralInformation(userInfo: user, serverInfo: server);
  }

  static UserInfo _userInfo(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return UserInfo(
      username: ValueParser.readString(
        json,
        'username',
        context,
        jsonPath,
      ),
      password: ValueParser.readString(
        json,
        'password',
        context,
        jsonPath,
      ),
      message: ValueParser.readString(
        json,
        'message',
        context,
        jsonPath,
      ),
      auth: ValueParser.readBool(
        json,
        'auth',
        context,
        jsonPath,
      ),
      status: ValueParser.readString(
        json,
        'status',
        context,
        jsonPath,
      ),
      expDate: ValueParser.readDateTimeUtc(
        json,
        'exp_date',
        context,
        jsonPath,
      ),
      isTrial: ValueParser.readBool(
        json,
        'is_trial',
        context,
        jsonPath,
      ),
      activeCons: ValueParser.readInt(
        json,
        'active_cons',
        context,
        jsonPath,
      ),
      createdAt: ValueParser.readDateTimeUtc(
        json,
        'created_at',
        context,
        jsonPath,
      ),
      maxConnections: ValueParser.readInt(
        json,
        'max_connections',
        context,
        jsonPath,
      ),
      allowedOutputFormats: ValueParser.readStringList(
        json,
        'allowed_output_formats',
        context,
        jsonPath,
      ),
    );
  }

  static ServerInfo _serverInfo(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return ServerInfo(
      xui: ValueParser.readBool(
        json,
        'xui',
        context,
        jsonPath,
      ),
      version: ValueParser.readString(
        json,
        'version',
        context,
        jsonPath,
      ),
      revision: ValueParser.readInt(
        json,
        'revision',
        context,
        jsonPath,
      ),
      url: ValueParser.readString(
        json,
        'url',
        context,
        jsonPath,
      ),
      port: ValueParser.readInt(
        json,
        'port',
        context,
        jsonPath,
      ),
      httpsPort: ValueParser.readInt(
        json,
        'https_port',
        context,
        jsonPath,
      ),
      serverProtocol: ValueParser.readString(
        json,
        'server_protocol',
        context,
        jsonPath,
      ),
      rtmpPort: ValueParser.readInt(
        json,
        'rtmp_port',
        context,
        jsonPath,
      ),
      timestampNow: ValueParser.readDateTimeUtc(
        json,
        'timestamp_now',
        context,
        jsonPath,
      ),
      timeNow: ValueParser.readDateTimeUtc(
        json,
        'time_now',
        context,
        jsonPath,
      ),
      timezone: ValueParser.readString(
        json,
        'timezone',
        context,
        jsonPath,
      ),
    );
  }
}
