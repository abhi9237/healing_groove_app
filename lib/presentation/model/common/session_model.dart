import 'package:json_annotation/json_annotation.dart';
part 'session_model.g.dart';

@JsonSerializable()
class SessionModel {
  String? id;
  String? createdAt;
  String? expiresAt;
  SessionModel({this.id, this.createdAt, this.expiresAt});

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
