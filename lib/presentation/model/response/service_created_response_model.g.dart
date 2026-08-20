// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_created_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCreatedResponseModel _$ServiceCreatedResponseModelFromJson(
  Map<String, dynamic> json,
) => ServiceCreatedResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ServiceCreatedResponseModelToJson(
  ServiceCreatedResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
