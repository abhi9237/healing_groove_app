// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatesModel _$DatesModelFromJson(Map<String, dynamic> json) => DatesModel(
  date: json['date'] as String?,
  booked: (json['booked'] as num?)?.toInt(),
  remaining: (json['remaining'] as num?)?.toInt(),
);

Map<String, dynamic> _$DatesModelToJson(DatesModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'booked': instance.booked,
      'remaining': instance.remaining,
    };
