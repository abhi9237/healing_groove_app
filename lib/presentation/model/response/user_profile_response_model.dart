import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_profile_response_model.g.dart';

@JsonSerializable()
class UserProfileResponseModel {
  UserModel? user;
  String? collection;
  String? strategy;
  int? exp;
  String? token;
  String? message;

  UserProfileResponseModel({this.user,
    this.collection,
    this.strategy,
    this.exp,
    this.token,
    this.message});

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    UserModel? user;
    if (json.containsKey('user') && json['user'] != null) {
      user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
    } else if (json.containsKey('data') && json['data'] != null) {
      user = UserModel.fromJson(json['data'] as Map<String, dynamic>);
    } else if (json.containsKey('email') || json.containsKey('id') || json.containsKey('name')) {
      user = UserModel.fromJson(json);
    }
    return UserProfileResponseModel(
      user: user,
      collection: json['collection'] as String?,
      strategy: json['strategy'] as String?,
      exp: (json['exp'] as num?)?.toInt(),
      token: json['token'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$UserProfileResponseModelToJson(this);
}
