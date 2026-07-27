import 'package:json_annotation/json_annotation.dart';
part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  double? latitude;
  double? longitude;

  CoordinatesModel({
   this.latitude,
    this.longitude
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
