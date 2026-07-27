import 'package:healing/common/common_methods.dart';
import 'package:healing/controller/book_program_controller.dart';
import 'package:healing/presentation/model/common/centre_model.dart';
import 'package:healing/presentation/model/common/guests_model.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import 'package:healing/presentation/model/common/location_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'package:healing/presentation/model/common/reviews_model.dart';
import 'package:healing/presentation/model/common/saved_centre_model.dart';
import 'package:healing/presentation/model/common/session_model.dart';
import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'amenities_model.dart';
part 'doc_model.g.dart';

@JsonSerializable()
class DocModel {
  int? id;
  String? title;
  String? name;
  String? description;
  String? phone;
  String? country;
  int? admin;
  int? rating;
  ImageModel? image;
  String? role;
  dynamic managedBy;
  String? status;
  bool? onboardingCompleted;
  dynamic dateOfBirth;
  int? age;
  String? gender;
  List<String>? wellnessGoals;
  List<String>? preferredActivities;
  List<SavedCentersModel>? savedCenters;
  dynamic specialization;
  dynamic qualification;
  dynamic experienceYears;
  dynamic consultationFee;
  String? updatedAt;
  String? createdAt;
  String? email;
  List<SessionModel>? sessions;
  LocationModel? location;
  int? reviewCount;
  int? minPrice;
  String? durationText;
  String? speciality;
  String? availability;
  List<ImageModel>? gallery;
  String? approvalStatus;
  int? capacity;
  int? numberOfRooms;
  List<String>? servicesOffered;
  List<String>? facilities;
  int? displayOrder;
  String? subject;
  String? message;
  String? sourceType;
  dynamic response;
  UserModel? user;
  List<AmenitiesModel>? amenities;
  ReviewsModel? reviews;
  int? userId;
  String? authorName;
  int? centerId;
  int? bookingId;
  String? text;
  CentreModel? center;
  PackagesModel? package;
  String? startDate;
  dynamic? slotTime;
  List<dynamic>? assignedDoctor;
  int? groupSize;
  List<GuestsModel>? guests;
  int? totalAmount;
  int? chargeAmount;
  String? chargeCurrency;
  bool? isSaved;
  dynamic confirmedAt;
  dynamic completedAt;
  dynamic rejectedAt;
  dynamic rejectionReason;
  dynamic cancelledAt;
  dynamic cancellationReason;
  dynamic refundStatus;
  dynamic adminRefundNote;
  dynamic cancellationPolicyScenario;
  dynamic cancellationPolicyRule;
  dynamic cancellationRefundPercent;
  dynamic cancellationRefundAmount;
  dynamic cancellationRejectedReason;
  dynamic cancellationApprovedAt;
  dynamic cancellationApprovedBy;
  dynamic refundInitiatedAt;
  dynamic razorpayRefundId;
  dynamic refundProcessedAt;

  DocModel({
    this.id,
    this.title,
    this.name,
    this.phone,
    this.amenities,
    this.country,
    this.role,
    this.managedBy,
    this.status,
    this.onboardingCompleted,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.wellnessGoals,
    this.preferredActivities,
    this.savedCenters,
    this.specialization,
    this.qualification,
    this.experienceYears,
    this.consultationFee,
    this.updatedAt,
    this.createdAt,
    this.isSaved,
    this.email,
    this.description,
    this.location,
    this.admin,
    this.image,
    this.rating,
    this.sessions,
    this.reviewCount,
    this.minPrice,
    this.durationText,
    this.speciality,
    this.availability,
    this.gallery,
    this.approvalStatus,
    this.capacity,
    this.numberOfRooms,
    this.servicesOffered,
    this.facilities,
    this.displayOrder,
    this.subject,
    this.message,
    this.sourceType,
    this.response,
    this.user,
    this.userId,
    this.authorName,
    this.centerId,
    this.bookingId,
    this.text,
    this.center,
    this.package,
    this.startDate,
    this.slotTime,
    this.assignedDoctor,
    this.groupSize,
    this.guests,
    this.reviews,
    this.chargeAmount,
    this.chargeCurrency,
    this.totalAmount,
    this.confirmedAt,
    this.completedAt,
    this.rejectedAt,
    this.rejectionReason,
    this.cancelledAt,
    this.cancellationReason,
    this.refundStatus,
    this.adminRefundNote,
    this.cancellationPolicyScenario,
    this.cancellationPolicyRule,
    this.cancellationRefundPercent,
    this.cancellationRefundAmount,
    this.cancellationRejectedReason,
    this.cancellationApprovedAt,
    this.cancellationApprovedBy,
    this.refundInitiatedAt,
    this.razorpayRefundId,
    this.refundProcessedAt,
  });

  factory DocModel.fromJson(Map<String, dynamic> json) {
    LocationModel? locationModel;
    if (json['location'] is Map<String, dynamic>) {
      locationModel = LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      );
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
      reviewsModel = ReviewsModel.fromJson(
        json['reviews'] as Map<String, dynamic>,
      );
    }

    UserModel? userModel;
    if (json['user'] is Map<String, dynamic>) {
      userModel = UserModel.fromJson(json['user'] as Map<String, dynamic>);
    }

    List<SessionModel>? sessionsList;
    if (json['sessions'] is List) {
      sessionsList = (json['sessions'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => SessionModel.fromJson(e))
          .toList();
    }

    List<String>? wellnessGoalsList;
    if (json['wellnessGoals'] is List) {
      wellnessGoalsList = (json['wellnessGoals'] as List)
          .map((e) => e.toString())
          .toList();
    }

    List<String>? preferredActivitiesList;
    if (json['preferredActivities'] is List) {
      preferredActivitiesList = (json['preferredActivities'] as List)
          .map((e) => e.toString())
          .toList();
    }

    List<SavedCentersModel>? savedCentersList;
    if (json['savedCenters'] != null && json['savedCenters'] is List) {
      savedCentersList = (json['savedCenters'] as List)
          .map((e) => SavedCentersModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    List<String>? servicesOfferedList;
    if (json['servicesOffered'] is List) {
      servicesOfferedList = (json['servicesOffered'] as List)
          .map((e) => e.toString())
          .toList();
    }

    List<String>? facilitiesList;
    if (json['facilities'] is List) {
      facilitiesList = (json['facilities'] as List)
          .map((e) => e.toString())
          .toList();
    }

    CentreModel? centerModel;
    if (json['center'] is Map<String, dynamic>) {
      centerModel = CentreModel.fromJson(json['center'] as Map<String, dynamic>);
    }

    PackagesModel? packageModel;
    if (json['package'] is Map<String, dynamic>) {
      packageModel = PackagesModel.fromJson(json['package'] as Map<String, dynamic>);
    }

    List<GuestsModel>? guestsList;
    if (json['guests'] is List) {
      guestsList = (json['guests'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => GuestsModel.fromJson(e))
          .toList();
    }

    return DocModel(
      id: parseInt(json['id']),
      title: json['title'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      amenities: amenitiesList,
      country: json['country'] as String?,
      role: json['role'] as String?,
      managedBy: json['managedBy'],
      status: json['status'] as String?,
      onboardingCompleted: json['onboardingCompleted'] is bool
          ? json['onboardingCompleted'] as bool
          : null,
      dateOfBirth: json['dateOfBirth'],
      age: parseInt(json['age']),
      gender: json['gender'] as String?,
      wellnessGoals: wellnessGoalsList,
      preferredActivities: preferredActivitiesList,
      savedCenters: savedCentersList,
      specialization: json['specialization'],
      qualification: json['qualification'],
      experienceYears: json['experienceYears'],
      consultationFee: json['consultationFee'],
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      location: locationModel,
      admin: parseInt(json['admin']),
      image: imageModel,
      rating: parseInt(json['rating']),
      sessions: sessionsList,
      reviewCount: parseInt(json['reviewCount']),
      minPrice: parseInt(json['minPrice']),
      durationText: json['durationText'] as String?,
      speciality: json['speciality'] as String?,
      availability: json['availability'] as String?,
      gallery: galleryList,
      approvalStatus: json['approvalStatus'] as String?,
      capacity: parseInt(json['capacity']),
      numberOfRooms: parseInt(json['numberOfRooms']),
      servicesOffered: servicesOfferedList,
      facilities: facilitiesList,
      displayOrder: parseInt(json['displayOrder']),
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      sourceType: json['sourceType'] as String?,
      response: json['response'],
      user: userModel,
      userId: parseInt(json['userId']),
      authorName: json['authorName'] as String?,
      centerId: parseInt(json['centerId']),
      bookingId: parseInt(json['bookingId']),
      text: json['text'] as String?,
      center: centerModel,
      package: packageModel,
      startDate: json['startDate'] as String?,
      slotTime: json['slotTime'],
      assignedDoctor: json['assignedDoctor'] as List<dynamic>?,
      groupSize: parseInt(json['groupSize']),
      guests: guestsList,
      totalAmount: parseInt(json['totalAmount']),
      chargeAmount: parseInt(json['chargeAmount']),
      chargeCurrency: json['chargeCurrency'] as String?,
      confirmedAt: json['confirmedAt'],
      completedAt: json['completedAt'],
      rejectedAt: json['rejectedAt'],
      rejectionReason: json['rejectionReason'],
      cancelledAt: json['cancelledAt'],
      cancellationReason: json['cancellationReason'],
      refundStatus: json['refundStatus'],
      adminRefundNote: json['adminRefundNote'],
      cancellationPolicyScenario: json['cancellationPolicyScenario'],
      cancellationPolicyRule: json['cancellationPolicyRule'],
      cancellationRefundPercent: json['cancellationRefundPercent'],
      cancellationRefundAmount: json['cancellationRefundAmount'],
      cancellationRejectedReason: json['cancellationRejectedReason'],
      cancellationApprovedAt: json['cancellationApprovedAt'],
      cancellationApprovedBy: json['cancellationApprovedBy'],
      refundInitiatedAt: json['refundInitiatedAt'],
      razorpayRefundId: json['razorpayRefundId'],
      refundProcessedAt: json['refundProcessedAt'],
      isSaved: json['isSaved']
    )..reviews = reviewsModel;
  }

  Map<String, dynamic> toJson() => _$DocModelToJson(this);
}
