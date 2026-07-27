import 'package:json_annotation/json_annotation.dart';
part 'amenities_model.g.dart';

@JsonSerializable()
class AmenitiesModel {
  String? id;
  String? icon;
  String? label;
  String? description;
  AmenitiesModel({this.id, this.icon, this.label, this.description});

  factory AmenitiesModel.fromJson(Map<String, dynamic> json) =>
      _$AmenitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AmenitiesModelToJson(this);
}
