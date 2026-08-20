import 'package:json_annotation/json_annotation.dart';
part 'assigned_doctor.g.dart';

@JsonSerializable()
class AssignedDoctor {
  int? id;
  String? name;
  String? email;
  String? specialization;
  AssignedDoctor({this.id, this.name, this.email, this.specialization});

  factory AssignedDoctor.fromJson(Map<String, dynamic> json) =>
      _$AssignedDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedDoctorToJson(this);
}
