import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'center_response_model.g.dart';

@JsonSerializable()
class CenterResponseModel {
  List<DocModel>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  String? nextPage;
  int? page;
  int? pagingCounter;
  String? prevPage;
  int? totalDocs;
  int? totalPages;

  CenterResponseModel({this.docs,
    this.hasNextPage,
    this.hasPrevPage,
    this.limit,
    this.nextPage,
    this.page,
    this.pagingCounter,
    this.prevPage,
    this.totalDocs,
    this.totalPages});

  factory CenterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CenterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterResponseModelToJson(this);
}
