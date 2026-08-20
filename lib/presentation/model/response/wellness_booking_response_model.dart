import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wellness_booking_response_model.g.dart';

@JsonSerializable()
class WellnessBookingResponseModel {
  List<DocModel>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? pagingCounter;
  int? prevPage;
  int? nextPage;

  WellnessBookingResponseModel({
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.hasNextPage,
    this.hasPrevPage,
    this.pagingCounter,
    this.prevPage,
    this.nextPage});

  factory WellnessBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WellnessBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WellnessBookingResponseModelToJson(this);
}
