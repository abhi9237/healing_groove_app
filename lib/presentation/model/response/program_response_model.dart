import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'program_response_model.g.dart';

@JsonSerializable()
class ProgramsResponseModel {
  List<DocModel>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  bool? hasNextPage;

  ProgramsResponseModel({this.docs, this.totalDocs, this.limit, this.page, this.hasNextPage});

  factory ProgramsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramsResponseModelToJson(this);
}
