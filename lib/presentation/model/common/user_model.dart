import 'package:healing/presentation/model/common/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'doc_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  int? centerId;
  String? name;
  String? phone;
  String? country;
  String? role;
  dynamic managedBy;
  String? status;
  bool? onboardingCompleted;
  dynamic dateOfBirth;
  int? age;
  String? gender;
  List<String>? wellnessGoals;
  List<String>? preferredActivities;
  List<DocModel>? savedCenters;
  dynamic specialization;
  dynamic qualification;
  dynamic experienceYears;
  dynamic consultationFee;
  String? updatedAt;
  String? createdAt;
  String? email;
  List<SessionModel>? sessions;
  String? collection;
  String? sStrategy;
  int? activeJourneyCount;
  int? myPackageCount;
  int? enquireCount;
  int? savedCenterCount;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.country,
    this.role,
    this.managedBy,
    this.status,
    this.onboardingCompleted,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.wellnessGoals,
    this.preferredActivities,
    this.savedCenters,
    this.specialization,
    this.qualification,
    this.experienceYears,
    this.consultationFee,
    this.updatedAt,
    this.createdAt,
    this.email,
    this.sessions,
    this.collection,
    this.sStrategy,
    this.activeJourneyCount,
    this.myPackageCount,
    this.enquireCount,
    this.savedCenterCount,
    this.centerId
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt(),
      centerId: (json['centerId'] as num?)?.toInt(),
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

      wellnessGoals: (json['wellnessGoals'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      preferredActivities: (json['preferredActivities'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      savedCenters: (json['savedCenters'] as List?)
          ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      specialization: json['specialization'],
      qualification: json['qualification'],
      experienceYears: json['experienceYears'],
      consultationFee: json['consultationFee'],

      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      email: json['email'] as String?,

      sessions: (json['sessions'] as List?)
          ?.map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      collection: json['collection'] as String?,
      sStrategy: json['_strategy'] as String?,

      activeJourneyCount:
      (json['active_journey_count'] as num?)?.toInt(),

      myPackageCount:
      (json['my_package_count'] as num?)?.toInt(),

      enquireCount:
      (json['enquire_count'] as num?)?.toInt(),

      savedCenterCount:
      (json['saved_center_count'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}