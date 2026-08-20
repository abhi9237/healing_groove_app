import 'package:healing/presentation/model/common/session_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'managed_by_model.g.dart';

@JsonSerializable()
class ManagedBy {
  int? id;
  String? name;
  String? phone;
  String? country;
  String? role;
  String? managedBy;
  String? status;
  bool? onboardingCompleted;
  String? dateOfBirth;
  int? age;
  String? gender;
  String? wellnessGoals;
  String? preferredActivities;
  List<dynamic>? savedCenters;
  dynamic specialization;
  dynamic qualification;
  dynamic experienceYears;
  dynamic consultationFee;
  String? updatedAt;
  String? createdAt;
  String? email;
  List<SessionModel>? sessions;

  ManagedBy({
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
    this.sessions
  });

  factory ManagedBy.fromJson(Map<String, dynamic> json) =>
      _$ManagedByFromJson(json);

  Map<String, dynamic> toJson() => _$ManagedByToJson(this);
}
