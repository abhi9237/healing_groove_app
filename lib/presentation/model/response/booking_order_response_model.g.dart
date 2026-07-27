// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingOrderResponseModel _$BookingOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => BookingOrderResponseModel(
  keyId: json['keyId'] as String?,
  orderId: json['orderId'] as String?,
  amountPaise: (json['amountPaise'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  paymentDocId: (json['paymentDocId'] as num?)?.toInt(),
  bookingId: (json['bookingId'] as num?)?.toInt(),
  bookingNumber: json['bookingNumber'] as String?,
);

Map<String, dynamic> _$BookingOrderResponseModelToJson(
  BookingOrderResponseModel instance,
) => <String, dynamic>{
  'keyId': instance.keyId,
  'orderId': instance.orderId,
  'amountPaise': instance.amountPaise,
  'currency': instance.currency,
  'paymentDocId': instance.paymentDocId,
  'bookingId': instance.bookingId,
  'bookingNumber': instance.bookingNumber,
};
