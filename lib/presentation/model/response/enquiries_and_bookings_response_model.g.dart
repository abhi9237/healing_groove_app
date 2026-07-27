// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiries_and_bookings_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiriesAndBookingsResponseModel _$EnquiriesAndBookingsResponseModelFromJson(
  Map<String, dynamic> json,
) => EnquiriesAndBookingsResponseModel(
  docs: (json['docs'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasNextPage: json['hasNextPage'] as bool?,
  hasPrevPage: json['hasPrevPage'] as bool?,
  limit: (json['limit'] as num?)?.toInt(),
  nextPage: (json['nextPage'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  pagingCounter: (json['pagingCounter'] as num?)?.toInt(),
  prevPage: (json['prevPage'] as num?)?.toInt(),
  totalDocs: (json['totalDocs'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
);

Map<String, dynamic> _$EnquiriesAndBookingsResponseModelToJson(
  EnquiriesAndBookingsResponseModel instance,
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
