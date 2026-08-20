// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_and_privacy_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsAndPrivacyResponseModel _$TermsAndPrivacyResponseModelFromJson(
  Map<String, dynamic> json,
) => TermsAndPrivacyResponseModel(
  json['slug'] as String?,
  json['title'] as String?,
  json['content'] as String?,
  json['lastUpdated'] as String?,
  json['updatedAt'] as String?,
  json['createdAt'] as String?,
);

Map<String, dynamic> _$TermsAndPrivacyResponseModelToJson(
  TermsAndPrivacyResponseModel instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'title': instance.title,
  'content': instance.content,
  'lastUpdated': instance.lastUpdated,
  'updatedAt': instance.updatedAt,
  'createdAt': instance.createdAt,
};
