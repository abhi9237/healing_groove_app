// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBookingResponseModel _$CancelBookingResponseModelFromJson(
  Map<String, dynamic> json,
) => CancelBookingResponseModel(
  preview: json['preview'] == null
      ? null
      : PreviewModel.fromJson(json['preview'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CancelBookingResponseModelToJson(
  CancelBookingResponseModel instance,
) => <String, dynamic>{'preview': instance.preview};
