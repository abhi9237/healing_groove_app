import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  bool? success;
  String? token;
  UserModel? user;
  int? exp;
  String? refreshToken;
  String? resetToken;

  VerifyOtpResponse({this.token, this.success, this.user, this.exp, this.refreshToken, this.resetToken});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    final model = _$VerifyOtpResponseFromJson(json);
    model.refreshToken = json['refreshToken'] as String? ?? json['refresh_token'] as String?;
    model.resetToken = json['resetToken'] as String? ?? json['resetToken'] as String?;
    return model;
  }

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}
