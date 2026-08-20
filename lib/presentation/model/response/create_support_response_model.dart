import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_support_response_model.g.dart';

@JsonSerializable()
class CreatedSupportResponseModel {
  DocModel? doc;
  String? message;
  CreatedSupportResponseModel(
      {this.doc, this.message});

  factory CreatedSupportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedSupportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedSupportResponseModelToJson(this);
}
