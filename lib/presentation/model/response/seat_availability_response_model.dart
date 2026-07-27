import 'package:healing/presentation/model/common/available_dates_model.dart';
import 'package:healing/presentation/model/common/dates_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'seat_availability_response_model.g.dart';

@JsonSerializable()
class SeatAvailabilityResponseModel {
  int? packageId;
  int? maxGuests;
  List<DatesModel>? dates;
  List<AvailableDatesModel>? availableDates;


  SeatAvailabilityResponseModel({this.packageId, this.maxGuests,
    // this.dates,
    this.availableDates});

  factory SeatAvailabilityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SeatAvailabilityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatAvailabilityResponseModelToJson(this);
}
