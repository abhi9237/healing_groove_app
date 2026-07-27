import 'package:json_annotation/json_annotation.dart';
part 'dates_model.g.dart';

@JsonSerializable()
class DatesModel {
  String? date;
  int? booked;
  int? remaining;
  DatesModel({this.date, this.booked, this.remaining});

  factory DatesModel.fromJson(Map<String, dynamic> json) =>
      _$DatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DatesModelToJson(this);
}
