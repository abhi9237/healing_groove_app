// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_cancellation_request_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCancellationRequestModel _$BookingCancellationRequestModelFromJson(
  Map<String, dynamic> json,
) => BookingCancellationRequestModel(
  success: json['success'] as bool?,
  bookingId: (json['bookingId'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BookingCancellationRequestModelToJson(
  BookingCancellationRequestModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'bookingId': instance.bookingId,
  'status': instance.status,
};
