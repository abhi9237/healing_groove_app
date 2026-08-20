import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_program_response_model.g.dart';

@JsonSerializable()
class AddProgramResponseModel {
  DocModel? doc;
  String? message;
  AddProgramResponseModel(
      {this.doc, this.message});

  factory AddProgramResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddProgramResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddProgramResponseModelToJson(this);
}
