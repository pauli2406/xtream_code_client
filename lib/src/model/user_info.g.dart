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
      expDate: dateTimeFromEpochSeconds(json['expDate'] as int),
      isTrial: json['isTrial'] as String?,
      activeCons: json['activeCons'] as String?,
      createdAt: dateTimeFromEpochSeconds(json['createdAt'] as int),
      maxConnections: json['maxConnections'] as String?,
      allowedOutputFormats: (json['allowedOutputFormats'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'message': instance.message,
      'auth': instance.auth,
      'status': instance.status,
      'expDate': instance.expDate.toIso8601String(),
      'isTrial': instance.isTrial,
      'activeCons': instance.activeCons,
      'createdAt': instance.createdAt.toIso8601String(),
      'maxConnections': instance.maxConnections,
      'allowedOutputFormats': instance.allowedOutputFormats,
    };
