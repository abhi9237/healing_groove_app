import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_response_model.g.dart';

@JsonSerializable()
class DoctorResponseModel {
  List<DocModel>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? nextPage;
  int? page;
  int? pagingCounter;
  int? prevPage;
  int? totalDocs;
  int? totalPages;
  DoctorResponseModel(
      {this.docs,
        this.hasNextPage,
        this.hasPrevPage,
        this.limit,
        this.nextPage,
        this.page,
        this.pagingCounter,
        this.prevPage,
        this.totalDocs,
        this.totalPages});

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResponseModelToJson(this);
}
