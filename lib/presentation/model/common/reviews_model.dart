import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reviews_model.g.dart';

@JsonSerializable()
class ReviewsModel {
  List<DocModel>? docs;
  bool? hasNextPage;
  ReviewsModel({this.docs, this.hasNextPage});

  factory ReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsModelToJson(this);
}
