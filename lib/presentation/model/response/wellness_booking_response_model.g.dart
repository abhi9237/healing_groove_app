// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellness_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WellnessBookingResponseModel _$WellnessBookingResponseModelFromJson(
  Map<String, dynamic> json,
) => WellnessBookingResponseModel(
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalDocs: (json['totalDocs'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  hasNextPage: json['hasNextPage'] as bool?,
  hasPrevPage: json['hasPrevPage'] as bool?,
  pagingCounter: (json['pagingCounter'] as num?)?.toInt(),
  prevPage: (json['prevPage'] as num?)?.toInt(),
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$WellnessBookingResponseModelToJson(
  WellnessBookingResponseModel instance,
) => <String, dynamic>{
  'docs': instance.docs,
  'totalDocs': instance.totalDocs,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
  'page': instance.page,
  'hasNextPage': instance.hasNextPage,
  'hasPrevPage': instance.hasPrevPage,
  'pagingCounter': instance.pagingCounter,
  'prevPage': instance.prevPage,
  'nextPage': instance.nextPage,
};
