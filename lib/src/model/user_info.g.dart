// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      username: json['username'] as String?,
      password: json['password'] as String?,
      message: json['message'] as String?,
      auth: json['auth'] as int?,
      status: json['status'] as String?,
      expDate: dateTimeFromEpochSeconds(json['exp_date'] as int),
      isTrial: json['is_trial'] as String?,
      activeCons: json['active_cons'] as String?,
      createdAt: dateTimeFromEpochSeconds(json['created_at'] as int),
      maxConnections: json['max_connections'] as String?,
      allowedOutputFormats: (json['allowed_output_formats'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'message': instance.message,
      'auth': instance.auth,
      'status': instance.status,
      'exp_date': instance.expDate.toIso8601String(),
      'is_trial': instance.isTrial,
      'active_cons': instance.activeCons,
      'created_at': instance.createdAt.toIso8601String(),
      'max_connections': instance.maxConnections,
      'allowed_output_formats': instance.allowedOutputFormats,
    };
