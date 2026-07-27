// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponseModel _$UserProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => UserProfileResponseModel(
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  collection: json['collection'] as String?,
  strategy: json['strategy'] as String?,
  exp: (json['exp'] as num?)?.toInt(),
  token: json['token'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$UserProfileResponseModelToJson(
  UserProfileResponseModel instance,
) => <String, dynamic>{
  'user': instance.user,
  'collection': instance.collection,
  'strategy': instance.strategy,
  'exp': instance.exp,
  'token': instance.token,
  'message': instance.message,
};
