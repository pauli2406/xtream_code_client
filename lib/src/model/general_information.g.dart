// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeGeneralInformation _$XTremeCodeGeneralInformationFromJson(
        Map<String, dynamic> json) =>
    XTremeCodeGeneralInformation(
      userInfo: XTremeCodeUserInfo.fromJson(
          json['user_info'] as Map<String, dynamic>),
      serverInfo: XTremeCodeServerInfo.fromJson(
          json['server_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$XTremeCodeGeneralInformationToJson(
        XTremeCodeGeneralInformation instance) =>
    <String, dynamic>{
      'user_info': instance.userInfo,
      'server_info': instance.serverInfo,
    };
