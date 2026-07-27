import 'package:healing/presentation/model/common/error_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponseModel {
  List<ErrorModel>? errors;

  ErrorResponseModel({this.errors});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
