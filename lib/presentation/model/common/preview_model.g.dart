// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewModel _$PreviewModelFromJson(Map<String, dynamic> json) => PreviewModel(
  bookingId: (json['bookingId'] as num?)?.toInt(),
  bookingNumber: json['bookingNumber'] as String?,
  programName: json['programName'] as String?,
  bookingDate: json['bookingDate'] as String?,
  programStartDate: json['programStartDate'] as String?,
  cancellationDate: json['cancellationDate'] as String?,
  scenario: json['scenario'] as String?,
  scenarioDescription: json['scenarioDescription'] as String?,
  policyRule: json['policyRule'] as String?,
  refundPercent: (json['refundPercent'] as num?)?.toInt(),
  refundAmount: (json['refundAmount'] as num?)?.toInt(),
  wellnessCreditEligible: json['wellnessCreditEligible'] as bool?,
  wellnessCreditAmount: (json['wellnessCreditAmount'] as num?)?.toInt(),
  daysBookingToStart: (json['daysBookingToStart'] as num?)?.toInt(),
  daysBeforeStart: (json['daysBeforeStart'] as num?)?.toInt(),
  hoursBeforeStart: (json['hoursBeforeStart'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PreviewModelToJson(PreviewModel instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'bookingNumber': instance.bookingNumber,
      'programName': instance.programName,
      'bookingDate': instance.bookingDate,
      'programStartDate': instance.programStartDate,
      'cancellationDate': instance.cancellationDate,
      'scenario': instance.scenario,
      'scenarioDescription': instance.scenarioDescription,
      'policyRule': instance.policyRule,
      'refundPercent': instance.refundPercent,
      'refundAmount': instance.refundAmount,
      'wellnessCreditEligible': instance.wellnessCreditEligible,
      'wellnessCreditAmount': instance.wellnessCreditAmount,
      'daysBookingToStart': instance.daysBookingToStart,
      'daysBeforeStart': instance.daysBeforeStart,
      'hoursBeforeStart': instance.hoursBeforeStart,
    };
