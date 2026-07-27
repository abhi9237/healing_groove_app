import 'package:json_annotation/json_annotation.dart';
part 'guests_model.g.dart';

@JsonSerializable()
class GuestsModel {
  String? id;
  String? fullName;
  int? age;
  String? gender;

  GuestsModel({this.id, this.fullName, this.age, this.gender});

  factory GuestsModel.fromJson(Map<String, dynamic> json) =>
      _$GuestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuestsModelToJson(this);
}
