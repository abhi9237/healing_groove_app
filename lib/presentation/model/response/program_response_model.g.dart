// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramsResponseModel _$ProgramsResponseModelFromJson(
  Map<String, dynamic> json,
) => ProgramsResponseModel(
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  hasNextPage: json['hasNextPage'] as bool?,
);

Map<String, dynamic> _$ProgramsResponseModelToJson(
  ProgramsResponseModel instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'hasNextPage': instance.hasNextPage,
};
