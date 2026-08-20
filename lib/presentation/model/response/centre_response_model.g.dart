// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centre_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CentreResponseModel _$CentreResponseModelFromJson(Map<String, dynamic> json) =>
    CentreResponseModel(
      doc: json['doc'] == null
          ? null
          : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CentreResponseModelToJson(
  CentreResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
