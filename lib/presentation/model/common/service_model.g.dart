// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
  id: (json['id'] as num?)?.toInt(),
  center: json['center'] == null
      ? null
      : CentreModel.fromJson(json['center'] as Map<String, dynamic>),
  name: json['name'] as String?,
  description: json['description'] as String?,
  basePrice: (json['basePrice'] as num?)?.toInt(),
  seasons: json['seasons'] as List<dynamic>?,
  isActive: json['isActive'] as bool?,
  updatedAt: json['updatedAt'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'center': instance.center,
      'name': instance.name,
      'description': instance.description,
      'basePrice': instance.basePrice,
      'seasons': instance.seasons,
      'isActive': instance.isActive,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
