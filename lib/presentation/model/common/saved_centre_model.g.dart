// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_centre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedCentersModel _$SavedCentersModelFromJson(Map<String, dynamic> json) =>
    SavedCentersModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      admin: (json['admin'] as num?)?.toInt(),
      image: json['image'] == null
          ? null
          : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      minPrice: (json['minPrice'] as num?)?.toInt(),
      durationText: json['durationText'] as String?,
      speciality: json['speciality'] as String?,
      availability: json['availability'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => AmenitiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvalStatus: json['approvalStatus'] as String?,
      capacity: (json['capacity'] as num?)?.toInt(),
      numberOfRooms: (json['numberOfRooms'] as num?)?.toInt(),
      servicesOffered: (json['servicesOffered'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      facilities: (json['facilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      reviews: json['reviews'] == null
          ? null
          : ReviewsModel.fromJson(json['reviews'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => PackagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSaved: json['isSaved'] as bool?,
    );

Map<String, dynamic> _$SavedCentersModelToJson(SavedCentersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'admin': instance.admin,
      'image': instance.image,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'minPrice': instance.minPrice,
      'durationText': instance.durationText,
      'speciality': instance.speciality,
      'availability': instance.availability,
      'gallery': instance.gallery,
      'amenities': instance.amenities,
      'approvalStatus': instance.approvalStatus,
      'capacity': instance.capacity,
      'numberOfRooms': instance.numberOfRooms,
      'servicesOffered': instance.servicesOffered,
      'facilities': instance.facilities,
      'displayOrder': instance.displayOrder,
      'reviews': instance.reviews,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'isSaved': instance.isSaved,
      'packages': instance.packages,
    };
