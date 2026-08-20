// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponse _$VerifyOtpResponseFromJson(Map<String, dynamic> json) =>
    VerifyOtpResponse(
      token: json['token'] as String?,
      success: json['success'] as bool?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      exp: (json['exp'] as num?)?.toInt(),
      refreshToken: json['refreshToken'] as String?,
      resetToken: json['resetToken'] as String?,
    );

Map<String, dynamic> _$VerifyOtpResponseToJson(VerifyOtpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'user': instance.user,
      'exp': instance.exp,
      'refreshToken': instance.refreshToken,
      'resetToken': instance.resetToken,
    };
