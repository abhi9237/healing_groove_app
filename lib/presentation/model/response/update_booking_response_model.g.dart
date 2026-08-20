// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingResponseModel _$UpdateBookingResponseModelFromJson(
  Map<String, dynamic> json,
) => UpdateBookingResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$UpdateBookingResponseModelToJson(
  UpdateBookingResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
