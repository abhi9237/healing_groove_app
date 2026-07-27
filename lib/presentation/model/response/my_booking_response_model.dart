import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'my_booking_response_model.g.dart';

@JsonSerializable()
class MyBookingResponseModel {
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

  MyBookingResponseModel({this.docs, this.hasNextPage, this.hasPrevPage, this.limit, this.nextPage, this.page, this.pagingCounter, this.prevPage, this.totalDocs, this.totalPages});

  factory MyBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyBookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookingResponseModelToJson(this);
}
