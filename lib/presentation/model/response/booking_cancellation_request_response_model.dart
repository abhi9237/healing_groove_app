import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_cancellation_request_response_model.g.dart';

@JsonSerializable()
class BookingCancellationRequestModel {
  bool? success;
  int? bookingId;
  String? status;

  BookingCancellationRequestModel(
      {this.success, this.bookingId, this.status});

  factory BookingCancellationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookingCancellationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingCancellationRequestModelToJson(this);
}
