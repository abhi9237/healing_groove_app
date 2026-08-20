import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'centre_response_model.g.dart';

@JsonSerializable()
class CentreResponseModel {
  DocModel? doc;
  String? message;
  CentreResponseModel(
      {this.doc, this.message});

  factory CentreResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CentreResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CentreResponseModelToJson(this);
}
