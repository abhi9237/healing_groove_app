import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_response_model.g.dart';

@JsonSerializable()
class BookingResponseModel {
  DocModel? doc;
  String? message;
  BookingResponseModel({this.doc, this.message});

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseModelToJson(this);
}
