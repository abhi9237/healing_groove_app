import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wellness_doctor_response_model.g.dart';

@JsonSerializable()
class WellnessDoctorResponseModel {
  DocModel? doc;
  String? message;
  WellnessDoctorResponseModel(
      {this.doc, this.message});

  factory WellnessDoctorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WellnessDoctorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WellnessDoctorResponseModelToJson(this);

}
