// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_support_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedSupportResponseModel _$CreatedSupportResponseModelFromJson(
  Map<String, dynamic> json,
) => CreatedSupportResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$CreatedSupportResponseModelToJson(
  CreatedSupportResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
