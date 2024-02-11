import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/model/server_info.dart';
import 'package:xtream_code_client/src/model/user_info.dart';

part 'general_information.g.dart';

/// Represents general information about the Xtream Code.
@JsonSerializable()
class XTremeCodeGeneralInformation {
  /// Creates a new instance of [XTremeCodeGeneralInformation].
  XTremeCodeGeneralInformation({
    required this.userInfo,
    required this.serverInfo,
  });

  /// Creates a new instance of [XTremeCodeGeneralInformation] from a JSON 
  /// object.
  factory XTremeCodeGeneralInformation.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeGeneralInformationFromJson(json);

  /// The user information.
  @JsonKey(name: 'user_info')
  final XTremeCodeUserInfo userInfo;

  /// The server information.
  @JsonKey(name: 'server_info')
  final XTremeCodeServerInfo serverInfo;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeGeneralInformationToJson(this);
}
