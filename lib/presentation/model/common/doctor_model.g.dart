// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  role: json['role'] as String?,
  specialization: json['specialization'] as String?,
  qualification: json['qualification'] as String?,
  experienceYears: (json['experienceYears'] as num?)?.toInt(),
  consultationFee: (json['consultationFee'] as num?)?.toInt(),
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'specialization': instance.specialization,
      'qualification': instance.qualification,
      'experienceYears': instance.experienceYears,
      'consultationFee': instance.consultationFee,
    };
