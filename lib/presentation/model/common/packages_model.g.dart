// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagesModel _$PackagesModelFromJson(Map<String, dynamic> json) =>
    PackagesModel(
      id: (json['id'] as num?)?.toInt(),
      center: json['center'] == null
          ? null
          : CentreModel.fromJson(json['center'] as Map<String, dynamic>),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      minGuests: (json['minGuests'] as num?)?.toInt(),
      maxGuests: (json['maxGuests'] as num?)?.toInt(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctors: json['doctors'] as List<dynamic>?,
      isActive: json['isActive'] as bool?,
      approvalStatus: json['approvalStatus'] as String?,
      image: json['image'] == null
          ? null
          : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      availableDates: (json['availableDates'] as List<dynamic>?)
          ?.map((e) => AvailableDatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$PackagesModelToJson(PackagesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'center': instance.center,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration': instance.duration,
      'minGuests': instance.minGuests,
      'maxGuests': instance.maxGuests,
      'services': instance.services,
      'doctors': instance.doctors,
      'isActive': instance.isActive,
      'approvalStatus': instance.approvalStatus,
      'image': instance.image,
      'displayOrder': instance.displayOrder,
      'availableDates': instance.availableDates,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
