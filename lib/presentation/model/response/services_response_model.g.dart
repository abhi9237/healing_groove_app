// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesResponseModel _$ServicesResponseModelFromJson(
  Map<String, dynamic> json,
) => ServicesResponseModel(
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServicesResponseModelToJson(
  ServicesResponseModel instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'page': instance.page,
};
