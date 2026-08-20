// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageModelResponse _$UploadImageModelResponseFromJson(
  Map<String, dynamic> json,
) => UploadImageModelResponse(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UploadImageModelResponseToJson(
  UploadImageModelResponse instance,
) => <String, dynamic>{'doc': instance.doc};
