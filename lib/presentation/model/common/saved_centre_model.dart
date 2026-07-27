import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/amenities_model.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import 'package:healing/presentation/model/common/location_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'package:healing/presentation/model/common/reviews_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'saved_centre_model.g.dart';

@JsonSerializable()
class SavedCentersModel {
  int? id;
  String? name;
  String? description;
  String? phone;
  String? email;
  LocationModel? location;
  int? admin;
  ImageModel? image;
  double? rating;
  int? reviewCount;
  int? minPrice;
  String? durationText;
  String? speciality;
  String? availability;
  List<int>? gallery;
  List<AmenitiesModel>? amenities;
  String? approvalStatus;
  int? capacity;
  int? numberOfRooms;
  List<String>? servicesOffered;
  List<String>? facilities;
  int? displayOrder;
  ReviewsModel? reviews;
  String? updatedAt;
  String? createdAt;
  bool? isSaved;
  List<PackagesModel>? packages;

  SavedCentersModel({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.email,
    this.location,
    this.admin,
    this.image,
    this.rating,
    this.reviewCount,
    this.minPrice,
    this.durationText,
    this.speciality,
    this.availability,
    this.gallery,
    this.amenities,
    this.approvalStatus,
    this.capacity,
    this.numberOfRooms,
    this.servicesOffered,
    this.facilities,
    this.displayOrder,
    this.reviews,
    this.updatedAt,
    this.createdAt,
    this.packages,
    this.isSaved,
  });

  factory SavedCentersModel.fromJson(Map<String, dynamic> json) {
    LocationModel? locationModel;
    if (json['location'] is Map<String, dynamic>) {
      locationModel = LocationModel.fromJson(json['location'] as Map<String, dynamic>);
    }

    ImageModel? imageModel;
    if (json['image'] is Map<String, dynamic>) {
      imageModel = ImageModel.fromJson(json['image'] as Map<String, dynamic>);
    } else if (json['image'] is String) {
      imageModel = ImageModel(url: json['image'] as String);
    } else if (json['image'] is num) {
      imageModel = ImageModel(id: (json['image'] as num).toInt());
    }

    List<AmenitiesModel>? amenitiesList;
    if (json['amenities'] is List) {
      amenitiesList = (json['amenities'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => AmenitiesModel.fromJson(e))
          .toList();
    }

    ReviewsModel? reviewsModel;
    if (json['reviews'] is Map<String, dynamic>) {
      reviewsModel = ReviewsModel.fromJson(json['reviews'] as Map<String, dynamic>);
    }

    List<PackagesModel>? packagesList;
    if (json['packages'] is List) {
      packagesList = (json['packages'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => PackagesModel.fromJson(e))
          .toList();
    }

    return SavedCentersModel(
      id: parseInt(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      location: locationModel,
      admin: parseInt(json['admin']),
      image: imageModel,
      rating: json['rating'] is num ? (json['rating'] as num).toDouble() : null,
      reviewCount: parseInt(json['reviewCount']),
      minPrice: parseInt(json['minPrice']),
      durationText: json['durationText'] as String?,
      speciality: json['speciality'] as String?,
      availability: json['availability'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      amenities: amenitiesList,
      approvalStatus: json['approvalStatus'] as String?,
      capacity: parseInt(json['capacity']),
      numberOfRooms: parseInt(json['numberOfRooms']),
      servicesOffered: (json['servicesOffered'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      facilities: (json['facilities'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      displayOrder: parseInt(json['displayOrder']),
      reviews: reviewsModel,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      packages: packagesList,
      isSaved: json['isSaved'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => _$SavedCentersModelToJson(this);
}
