// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponseModel _$BookingResponseModelFromJson(
  Map<String, dynamic> json,
) => BookingResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BookingResponseModelToJson(
  BookingResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
