// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  country: json['country'] as String?,
  role: json['role'] as String?,
  managedBy: json['managedBy'],
  status: json['status'] as String?,
  onboardingCompleted: json['onboardingCompleted'] as bool?,
  dateOfBirth: json['dateOfBirth'],
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  wellnessGoals: (json['wellnessGoals'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  preferredActivities: (json['preferredActivities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  savedCenters: (json['savedCenters'] as List<dynamic>?)
      ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  collection: json['collection'] as String?,
  sStrategy: json['sStrategy'] as String?,
  activeJourneyCount: (json['activeJourneyCount'] as num?)?.toInt(),
  myPackageCount: (json['myPackageCount'] as num?)?.toInt(),
  enquireCount: (json['enquireCount'] as num?)?.toInt(),
  savedCenterCount: (json['savedCenterCount'] as num?)?.toInt(),
  centerId: (json['centerId'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'centerId': instance.centerId,
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
  'collection': instance.collection,
  'sStrategy': instance.sStrategy,
  'activeJourneyCount': instance.activeJourneyCount,
  'myPackageCount': instance.myPackageCount,
  'enquireCount': instance.enquireCount,
  'savedCenterCount': instance.savedCenterCount,
};
