import 'package:healing/presentation/model/common/error_model.dart';
import 'package:healing/presentation/model/common/saved_centre_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_saved_centre_response_model.g.dart';

@JsonSerializable()
class GetSavedCentreResponseModel {
  bool? success;
  List<SavedCentersModel>? savedCenters;

  GetSavedCentreResponseModel({this.success, this.savedCenters});

  factory GetSavedCentreResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetSavedCentreResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSavedCentreResponseModelToJson(this);
}
