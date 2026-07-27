import 'package:healing/presentation/model/common/session_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'doc_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
