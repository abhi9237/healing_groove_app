import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'enquiries_and_bookings_response_model.g.dart';

@JsonSerializable()
class EnquiriesAndBookingsResponseModel {
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
  EnquiriesAndBookingsResponseModel(
      {this.docs, this.hasNextPage, this.hasPrevPage, this.limit, this.nextPage, this.page, this.pagingCounter, this.prevPage, this.totalDocs, this.totalPages});

  factory EnquiriesAndBookingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EnquiriesAndBookingsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiriesAndBookingsResponseModelToJson(this);
}
