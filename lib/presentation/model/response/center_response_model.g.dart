// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterResponseModel _$CenterResponseModelFromJson(Map<String, dynamic> json) =>
    CenterResponseModel(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNextPage: json['hasNextPage'] as bool?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      limit: (json['limit'] as num?)?.toInt(),
      nextPage: json['nextPage'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pagingCounter: (json['pagingCounter'] as num?)?.toInt(),
      prevPage: json['prevPage'] as String?,
      totalDocs: (json['totalDocs'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CenterResponseModelToJson(
  CenterResponseModel instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
  'limit': instance.limit,
  'nextPage': instance.nextPage,
  'page': instance.page,
  'pagingCounter': instance.pagingCounter,
  'prevPage': instance.prevPage,
  'totalDocs': instance.totalDocs,
  'totalPages': instance.totalPages,
};
