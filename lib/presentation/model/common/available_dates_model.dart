import 'package:json_annotation/json_annotation.dart';

part 'available_dates_model.g.dart';

@JsonSerializable()
class AvailableDatesModel {
  String? id;
  String? date;
  String? status;
  AvailableDatesModel({this.id, this.date, this.status});

  factory AvailableDatesModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableDatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDatesModelToJson(this);
}
