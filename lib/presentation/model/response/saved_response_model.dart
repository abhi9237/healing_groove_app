import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'saved_response_model.g.dart';

@JsonSerializable()
class SavedCentreResponseModel {
  bool? success;
  String? action;
  List<int>? savedCenters;

  SavedCentreResponseModel({this.success, this.action, this.savedCenters});

  factory SavedCentreResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedCentreResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedCentreResponseModelToJson(this);
}
