import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/amenities_model.dart';
import 'package:healing/presentation/model/common/location_model.dart';
import 'package:healing/presentation/model/common/reviews_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'image_model.dart';

part 'centre_model.g.dart';

@JsonSerializable()
class CentreModel {
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
  dynamic minPrice;
  dynamic durationText;
  String? speciality;
  dynamic availability;
  List<dynamic>? gallery;
  List<AmenitiesModel>? amenities;
  String? approvalStatus;
  dynamic capacity;
  dynamic numberOfRooms;
  dynamic servicesOffered;
  dynamic facilities;
  int? displayOrder;
  ReviewsModel? reviews;
  String? updatedAt;
  String? createdAt;
  CentreModel({this.id, this.name, this.description, this.phone, this.email, this.location, this.admin, this.image, this.rating, this.reviewCount, this.minPrice, this.durationText, this.speciality, this.availability, this.gallery, this.amenities, this.approvalStatus, this.capacity, this.numberOfRooms, this.servicesOffered, this.facilities, this.displayOrder, this.reviews, this.updatedAt, this.createdAt});

  factory CentreModel.fromJson(Map<String, dynamic> json) {
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

    List<ImageModel>? galleryList;
    if (json['gallery'] is List) {
      galleryList = [];
      for (var item in (json['gallery'] as List)) {
        if (item is Map<String, dynamic>) {
          galleryList.add(ImageModel.fromJson(item));
        } else if (item is String) {
          galleryList.add(ImageModel(url: item));
        } else if (item is num) {
          galleryList.add(ImageModel(id: item.toInt()));
        }
      }
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

    return CentreModel(
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
      minPrice: json['minPrice'],
      durationText: json['durationText'] as String?,
      speciality: json['speciality'] as String?,
      availability: json['availability'],
      gallery: galleryList,
      amenities: amenitiesList,
      approvalStatus: json['approvalStatus'] as String?,
      capacity: json['capacity'],
      numberOfRooms: json['numberOfRooms'],
      servicesOffered: json['servicesOffered'],
      facilities: json['facilities'],
      displayOrder: parseInt(json['displayOrder']),
      reviews: reviewsModel,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$CentreModelToJson(this);
}
