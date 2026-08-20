import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'services_response_model.g.dart';

@JsonSerializable()
class ServicesResponseModel {
  List<DocModel>? docs;
  int? totalDocs;
  int? limit;
  int? page;

  ServicesResponseModel({this.docs, this.totalDocs, this.limit, this.page});

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesResponseModelToJson(this);
}
