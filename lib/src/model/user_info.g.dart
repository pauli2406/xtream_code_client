// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeUserInfo _$XTremeCodeUserInfoFromJson(Map<String, dynamic> json) =>
    XTremeCodeUserInfo(
      username: json['username'] as String?,
      password: json['password'] as String?,
      message: json['message'] as String?,
      auth: dynamicToBool(json['auth']),
      status: json['status'] as String?,
      expDate: dateTimeFromEpochSeconds(json['exp_date']),
      isTrial: dynamicToBool(json['is_trial']),
      activeCons: dynamicToIntConverter(json['active_cons']),
      createdAt: dateTimeFromEpochSeconds(json['created_at']),
      maxConnections: dynamicToIntConverter(json['max_connections']),
      allowedOutputFormats: (json['allowed_output_formats'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$XTremeCodeUserInfoToJson(XTremeCodeUserInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'message': instance.message,
      'auth': instance.auth,
      'status': instance.status,
      'exp_date': instance.expDate?.toIso8601String(),
      'is_trial': instance.isTrial,
      'active_cons': instance.activeCons,
      'created_at': instance.createdAt?.toIso8601String(),
      'max_connections': instance.maxConnections,
      'allowed_output_formats': instance.allowedOutputFormats,
    };
