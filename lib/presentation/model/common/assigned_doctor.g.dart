// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedDoctor _$AssignedDoctorFromJson(Map<String, dynamic> json) =>
    AssignedDoctor(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      specialization: json['specialization'] as String?,
    );

Map<String, dynamic> _$AssignedDoctorToJson(AssignedDoctor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'specialization': instance.specialization,
    };
