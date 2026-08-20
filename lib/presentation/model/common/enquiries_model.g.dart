// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiriesModel _$EnquiriesModelFromJson(Map<String, dynamic> json) =>
    EnquiriesModel(
      concern: json['concern'] as String?,
      wellnessGoals: (json['wellnessGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      groupSize: (json['groupSize'] as num?)?.toInt(),
      preferredDate: json['preferredDate'] as String?,
      guestDetails: (json['guestDetails'] as List<dynamic>?)
          ?.map((e) => GuestsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stayDuration: json['stayDuration'] as String?,
      preferredContact: json['preferredContact'] as String?,
      budgetComfort: json['budgetComfort'] as String?,
    );

Map<String, dynamic> _$EnquiriesModelToJson(EnquiriesModel instance) =>
    <String, dynamic>{
      'concern': instance.concern,
      'wellnessGoals': instance.wellnessGoals,
      'groupSize': instance.groupSize,
      'preferredDate': instance.preferredDate,
      'guestDetails': instance.guestDetails,
      'stayDuration': instance.stayDuration,
      'preferredContact': instance.preferredContact,
      'budgetComfort': instance.budgetComfort,
    };
