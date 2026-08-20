import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_created_response_model.g.dart';

@JsonSerializable()
class ServiceCreatedResponseModel {
  DocModel? doc;
  String? message;

  ServiceCreatedResponseModel({this.doc, this.message});

  factory ServiceCreatedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCreatedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCreatedResponseModelToJson(this);
}
