import 'package:json_annotation/json_annotation.dart';
part 'terms_and_privacy_response_model.g.dart';

@JsonSerializable()
class TermsAndPrivacyResponseModel {
  String? slug;
  String? title;
  String? content;
  String? lastUpdated;
  String? updatedAt;
  String? createdAt;

  TermsAndPrivacyResponseModel(this.slug,
    this.title,
    this.content,
    this.lastUpdated,
    this.updatedAt,
    this.createdAt);

  factory TermsAndPrivacyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TermsAndPrivacyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsAndPrivacyResponseModelToJson(this);
}
