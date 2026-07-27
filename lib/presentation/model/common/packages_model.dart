import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/available_dates_model.dart';
import 'package:healing/presentation/model/common/coordinates_model.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import 'package:healing/presentation/model/common/service_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'centre_model.dart';
part 'packages_model.g.dart';

@JsonSerializable()
class PackagesModel {
  int? id;
  CentreModel? center;
  String? name;
  String? description;
  int? price;
  int? duration;
  int? minGuests;
  int? maxGuests;
  List<ServiceModel>? services;
  List<dynamic>? doctors;
  bool? isActive;
  String? approvalStatus;
  ImageModel? image;
  int? displayOrder;
  List<AvailableDatesModel>? availableDates;
  String? updatedAt;
  String? createdAt;

  PackagesModel({this.id, this.center, this.name, this.description, this.price, this.duration, this.minGuests, this.maxGuests, this.services, this.doctors, this.isActive, this.approvalStatus, this.image, this.displayOrder, this.availableDates, this.updatedAt, this.createdAt});

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    CentreModel? centerModel;
    if (json['center'] is Map<String, dynamic>) {
      centerModel = CentreModel.fromJson(json['center'] as Map<String, dynamic>);
    }

    List<ServiceModel>? servicesList;
    if (json['services'] is List) {
      servicesList = [];
      for (var e in (json['services'] as List)) {
        if (e is Map<String, dynamic>) {
          servicesList.add(ServiceModel.fromJson(e));
        } else if (e is String) {
          servicesList.add(ServiceModel(name: e));
        }
      }
    }

    ImageModel? imageModel;
    if (json['image'] is Map<String, dynamic>) {
      imageModel = ImageModel.fromJson(json['image'] as Map<String, dynamic>);
    } else if (json['image'] is String) {
      imageModel = ImageModel(url: json['image'] as String);
    }

    List<AvailableDatesModel>? datesList;
    if (json['availableDates'] is List) {
      datesList = (json['availableDates'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => AvailableDatesModel.fromJson(e))
          .toList();
    }

    return PackagesModel(
      id: parseInt(json['id']),
      center: centerModel,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: parseInt(json['price']),
      duration: parseInt(json['duration']),
      minGuests: parseInt(json['minGuests']),
      maxGuests: parseInt(json['maxGuests']),
      services: servicesList,
      doctors: json['doctors'] is List ? json['doctors'] as List<dynamic> : null,
      isActive: json['isActive'] is bool ? json['isActive'] as bool : null,
      approvalStatus: json['approvalStatus'] as String?,
      image: imageModel,
      displayOrder: parseInt(json['displayOrder']),
      availableDates: datesList,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$PackagesModelToJson(this);
}
