import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_booking_response_model.g.dart';

@JsonSerializable()
class UpdateBookingResponseModel {
  DocModel? doc;
  String? message;

  UpdateBookingResponseModel({this.doc, this.message});

  factory UpdateBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBookingResponseModelToJson(this);
}
