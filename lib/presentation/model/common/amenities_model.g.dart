// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amenities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmenitiesModel _$AmenitiesModelFromJson(Map<String, dynamic> json) =>
    AmenitiesModel(
      id: json['id'] as String?,
      icon: json['icon'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AmenitiesModelToJson(AmenitiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'label': instance.label,
      'description': instance.description,
    };
