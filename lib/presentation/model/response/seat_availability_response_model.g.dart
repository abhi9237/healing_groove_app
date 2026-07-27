// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_availability_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatAvailabilityResponseModel _$SeatAvailabilityResponseModelFromJson(
  Map<String, dynamic> json,
) =>
    SeatAvailabilityResponseModel(
        packageId: (json['packageId'] as num?)?.toInt(),
        maxGuests: (json['maxGuests'] as num?)?.toInt(),
        availableDates: (json['availableDates'] as List<dynamic>?)
            ?.map(
              (e) => AvailableDatesModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      )
      ..dates = (json['dates'] as List<dynamic>?)
          ?.map((e) => DatesModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SeatAvailabilityResponseModelToJson(
  SeatAvailabilityResponseModel instance,
) => <String, dynamic>{
  'packageId': instance.packageId,
  'maxGuests': instance.maxGuests,
  'dates': instance.dates,
  'availableDates': instance.availableDates,
};
