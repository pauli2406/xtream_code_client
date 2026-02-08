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
      username:
          ValueParser.asString(json['username'], context, '$jsonPath.username'),
      password:
          ValueParser.asString(json['password'], context, '$jsonPath.password'),
      message:
          ValueParser.asString(json['message'], context, '$jsonPath.message'),
      auth: ValueParser.asBool(json['auth'], context, '$jsonPath.auth'),
      status: ValueParser.asString(json['status'], context, '$jsonPath.status'),
      expDate: ValueParser.asDateTimeUtc(
          json['exp_date'], context, '$jsonPath.exp_date'),
      isTrial:
          ValueParser.asBool(json['is_trial'], context, '$jsonPath.is_trial'),
      activeCons: ValueParser.asInt(
          json['active_cons'], context, '$jsonPath.active_cons'),
      createdAt: ValueParser.asDateTimeUtc(
          json['created_at'], context, '$jsonPath.created_at'),
      maxConnections: ValueParser.asInt(
        json['max_connections'],
        context,
        '$jsonPath.max_connections',
      ),
      allowedOutputFormats: ValueParser.asStringList(
        json['allowed_output_formats'],
        context,
        '$jsonPath.allowed_output_formats',
      ),
    );
  }

  static ServerInfo _serverInfo(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return ServerInfo(
      xui: ValueParser.asBool(json['xui'], context, '$jsonPath.xui'),
      version:
          ValueParser.asString(json['version'], context, '$jsonPath.version'),
      revision:
          ValueParser.asInt(json['revision'], context, '$jsonPath.revision'),
      url: ValueParser.asString(json['url'], context, '$jsonPath.url'),
      port: ValueParser.asInt(json['port'], context, '$jsonPath.port'),
      httpsPort: ValueParser.asInt(
          json['https_port'], context, '$jsonPath.https_port'),
      serverProtocol: ValueParser.asString(
        json['server_protocol'],
        context,
        '$jsonPath.server_protocol',
      ),
      rtmpPort:
          ValueParser.asInt(json['rtmp_port'], context, '$jsonPath.rtmp_port'),
      timestampNow: ValueParser.asDateTimeUtc(
        json['timestamp_now'],
        context,
        '$jsonPath.timestamp_now',
      ),
      timeNow: ValueParser.asDateTimeUtc(
          json['time_now'], context, '$jsonPath.time_now'),
      timezone:
          ValueParser.asString(json['timezone'], context, '$jsonPath.timezone'),
    );
  }
}
