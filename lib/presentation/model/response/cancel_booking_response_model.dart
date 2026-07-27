import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/preview_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cancel_booking_response_model.g.dart';

@JsonSerializable()
class CancelBookingResponseModel {
  PreviewModel? preview;
  CancelBookingResponseModel({this.preview});

  factory CancelBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CancelBookingResponseModelToJson(this);
}
