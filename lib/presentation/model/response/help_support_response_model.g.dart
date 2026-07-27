// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_support_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpAndSupportResponseModel _$HelpAndSupportResponseModelFromJson(
  Map<String, dynamic> json,
) => HelpAndSupportResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HelpAndSupportResponseModelToJson(
  HelpAndSupportResponseModel instance,
) => <String, dynamic>{
  'doc': instance.doc,
  'docs': instance.docs,
  'message': instance.message,
};
