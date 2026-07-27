import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  bool? success;
  String? token;
  UserModel? user;
  int? exp;

  VerifyOtpResponse({this.token, this.success, this.user, this.exp});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}
