import 'package:json_annotation/json_annotation.dart';
part 'send_otp_response_model.g.dart';

@JsonSerializable()
class SendOtpResponse {
  bool? success;
  String? message;

  SendOtpResponse({this.message, this.success});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpResponseToJson(this);
}
