import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LogInResponseModel {
  String? message;
  int? exp;
  String? token;
  UserModel? user;


  LogInResponseModel({this.message, this.exp, this.token, this.user});

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LogInResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogInResponseModelToJson(this);
}
