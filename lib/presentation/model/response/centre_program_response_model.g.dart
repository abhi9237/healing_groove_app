// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centre_program_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterProgramResponseModel _$CenterProgramResponseModelFromJson(
  Map<String, dynamic> json,
) => CenterProgramResponseModel(
  centerId: (json['centerId'] as num?)?.toInt(),
  packages: (json['packages'] as List<dynamic>?)
      ?.map((e) => PackagesModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: json['meta'] == null
      ? null
      : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CenterProgramResponseModelToJson(
  CenterProgramResponseModel instance,
) => <String, dynamic>{
  'centerId': instance.centerId,
  'packages': instance.packages,
  'meta': instance.meta,
};
