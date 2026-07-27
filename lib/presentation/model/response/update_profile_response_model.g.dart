// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponseModel _$UpdateProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => UpdateProfileResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$UpdateProfileResponseModelToJson(
  UpdateProfileResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
