// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellness_doctor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WellnessDoctorResponseModel _$WellnessDoctorResponseModelFromJson(
  Map<String, dynamic> json,
) => WellnessDoctorResponseModel(
  doc: json['doc'] == null
      ? null
      : DocModel.fromJson(json['doc'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$WellnessDoctorResponseModelToJson(
  WellnessDoctorResponseModel instance,
) => <String, dynamic>{'doc': instance.doc, 'message': instance.message};
