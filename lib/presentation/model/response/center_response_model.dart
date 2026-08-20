import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/packages_model.dart';
part 'center_response_model.g.dart';

@JsonSerializable()
class CenterResponseModel {
  List<DocModel>? docs;
  List<DocModel>? centres;
  List<PackagesModel>? packages;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? nextPage;
  int? page;
  int? pagingCounter;
  int? prevPage;
  int? totalDocs;
  int? totalPages;

  CenterResponseModel({this.docs,
    this.hasNextPage,
    this.hasPrevPage,
    this.limit,
    this.centres,
    this.nextPage,
    this.page,
    this.pagingCounter,
    this.packages,
    this.prevPage,
    this.totalDocs,
    this.totalPages});

  factory CenterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CenterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterResponseModelToJson(this);
}
