import 'package:healing/presentation/model/common/coordinates_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  CoordinatesModel? coordinates;

  LocationModel({
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
