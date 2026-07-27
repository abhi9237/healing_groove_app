import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_order_response_model.g.dart';

@JsonSerializable()
class BookingOrderResponseModel {
  String? keyId;
  String? orderId;
  int? amountPaise;
  String? currency;
  int? paymentDocId;
  int? bookingId;
  String? bookingNumber;

  BookingOrderResponseModel(
  {this.keyId,
  this.orderId,
  this.amountPaise,
  this.currency,
  this.paymentDocId,
  this.bookingId,
  this.bookingNumber});

  factory BookingOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookingOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingOrderResponseModelToJson(this);
}
