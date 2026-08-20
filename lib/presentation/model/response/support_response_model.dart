import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'support_response_model.g.dart';

@JsonSerializable()
class SupportResponseModel {
  List<DocModel>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;
  SupportResponseModel({this.docs, this.totalDocs, this.limit, this.page, this.hasNextPage, this.hasPrevPage});

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SupportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportResponseModelToJson(this);
}
