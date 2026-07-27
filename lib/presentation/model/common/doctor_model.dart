import 'package:healing/common/common_methods.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  int? id;
  String? name;
  String? role;
  String? specialization;
  String? qualification;
  int? experienceYears;
  int? consultationFee;


  DoctorModel(
  {this.id, this.name, this.role, this.specialization, this.qualification, this.experienceYears, this.consultationFee});

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: parseInt(json['id']),
    name: json['name'] as String?,
    role: json['role'] as String?,
    specialization: json['specialization'] as String?,
    qualification: json['qualification'] as String?,
    experienceYears: parseInt(json['experienceYears']),
    consultationFee: parseInt(json['consultationFee']),
  );

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
