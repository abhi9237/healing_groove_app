// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_program_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProgramResponseModel _$AddProgramResponseModelFromJson(
  Map<String, dynamic> json,
) => AddProgramResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AddProgramResponseModelToJson(
  AddProgramResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
