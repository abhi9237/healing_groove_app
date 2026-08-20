import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LogInResponseModel {
  String? message;
  int? exp;
  String? token;
  UserModel? user;
  String? refreshToken;


  LogInResponseModel({this.message, this.exp, this.token, this.user, this.refreshToken});

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) {
    final model = _$LogInResponseModelFromJson(json);
    model.refreshToken = json['refreshToken'] as String? ?? json['refresh_token'] as String?;
    return model;
  }

  Map<String, dynamic> toJson() => _$LogInResponseModelToJson(this);
}
