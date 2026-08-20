// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInResponseModel _$LogInResponseModelFromJson(Map<String, dynamic> json) =>
    LogInResponseModel(
      message: json['message'] as String?,
      exp: (json['exp'] as num?)?.toInt(),
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$LogInResponseModelToJson(LogInResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exp': instance.exp,
      'token': instance.token,
      'user': instance.user,
      'refreshToken': instance.refreshToken,
    };
