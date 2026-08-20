// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportResponseModel _$SupportResponseModelFromJson(
  Map<String, dynamic> json,
) => SupportResponseModel(
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  hasNextPage: json['hasNextPage'] as bool?,
  hasPrevPage: json['hasPrevPage'] as bool?,
);

Map<String, dynamic> _$SupportResponseModelToJson(
  SupportResponseModel instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
};
