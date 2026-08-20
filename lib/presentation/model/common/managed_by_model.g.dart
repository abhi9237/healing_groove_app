// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_by_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagedBy _$ManagedByFromJson(Map<String, dynamic> json) => ManagedBy(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  country: json['country'] as String?,
  role: json['role'] as String?,
  managedBy: json['managedBy'] as String?,
  status: json['status'] as String?,
  onboardingCompleted: json['onboardingCompleted'] as bool?,
  dateOfBirth: json['dateOfBirth'] as String?,
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  wellnessGoals: json['wellnessGoals'] as String?,
  preferredActivities: json['preferredActivities'] as String?,
  savedCenters: json['savedCenters'] as List<dynamic>?,
  specialization: json['specialization'],
  qualification: json['qualification'],
  experienceYears: json['experienceYears'],
  consultationFee: json['consultationFee'],
  updatedAt: json['updatedAt'] as String?,
  createdAt: json['createdAt'] as String?,
  email: json['email'] as String?,
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ManagedByToJson(ManagedBy instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'country': instance.country,
  'role': instance.role,
  'managedBy': instance.managedBy,
  'status': instance.status,
  'onboardingCompleted': instance.onboardingCompleted,
  'dateOfBirth': instance.dateOfBirth,
  'age': instance.age,
  'gender': instance.gender,
  'wellnessGoals': instance.wellnessGoals,
  'preferredActivities': instance.preferredActivities,
  'savedCenters': instance.savedCenters,
  'specialization': instance.specialization,
  'qualification': instance.qualification,
  'experienceYears': instance.experienceYears,
  'consultationFee': instance.consultationFee,
  'updatedAt': instance.updatedAt,
  'createdAt': instance.createdAt,
  'email': instance.email,
  'sessions': instance.sessions,
};
