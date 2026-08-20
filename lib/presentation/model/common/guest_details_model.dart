import 'package:json_annotation/json_annotation.dart';
part 'guest_details_model.g.dart';

@JsonSerializable()
class GuestsDetailsModel {
  String? name;
  String? age;
  String? gender;

  GuestsDetailsModel({this.name, this.age, this.gender});

  factory GuestsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GuestsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuestsDetailsModelToJson(this);
}
