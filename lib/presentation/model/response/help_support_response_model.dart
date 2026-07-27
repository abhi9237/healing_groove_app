import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'help_support_response_model.g.dart';

@JsonSerializable()
class HelpAndSupportResponseModel {
  DocModel? doc;
  List<DocModel>? docs;
  String? message;

  HelpAndSupportResponseModel({this.doc, this.message, this.docs});

  factory HelpAndSupportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HelpAndSupportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HelpAndSupportResponseModelToJson(this);
}
