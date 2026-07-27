import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_profile_response_model.g.dart';

@JsonSerializable()
class UpdateProfileResponseModel {
  DocModel? doc;
  String? message;

  UpdateProfileResponseModel({this.doc, this.message});

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseModelToJson(this);
}
