import 'package:healing/common/common_methods.dart';
import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:healing/presentation/model/common/assigned_doctor.dart';
import 'package:healing/presentation/model/common/centre_model.dart';
import 'package:healing/presentation/model/common/doctor_model.dart';
import 'package:healing/presentation/model/common/enquiries_model.dart';
import 'package:healing/presentation/model/common/guests_model.dart';
import 'package:healing/presentation/model/common/image_model.dart';
import 'package:healing/presentation/model/common/location_model.dart';
import 'package:healing/presentation/model/common/managed_by_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'package:healing/presentation/model/common/reviews_model.dart';
import 'package:healing/presentation/model/common/saved_centre_model.dart';
import 'package:healing/presentation/model/common/service_model.dart';
import 'package:healing/presentation/model/common/available_dates_model.dart';
import 'package:healing/presentation/model/common/session_model.dart';
import 'package:healing/presentation/model/common/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'amenities_model.dart';
part 'doc_model.g.dart';

@JsonSerializable()
class DocModel {
  int? id;
  String? url;
  String? bookingNumber;
  String? filename;
  String? mimeType;
  int? filesize;
  int? width;
  int? height;
  String? title;
  String? name;
  String? description;
  String? phone;
  String? country;
  int? admin;
  int? rating;
  ImageModel? image;
  String? role;
  ManagedBy? managedBy;
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
  int? basePrice;
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
  List<PackagesModel>? packages;
  String? startDate;
  dynamic? slotTime;
  List<AssignedDoctor>? assignedDoctor;
  int? groupSize;
  List<GuestsModel>? guests;
  int? totalAmount;
  int? chargeAmount;
  String? chargeCurrency;
  bool? isSaved;
  bool? isActive;
  List<ServiceModel>? services;
  List<DoctorModel>? doctors;
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
  EnquiriesModel? enquiries;
  int? price;
  int? duration;
  int? minGuests;
  int? maxGuests;
  List<AvailableDatesModel>? availableDates;
  bool? hasConsultation;

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
    this.packages,
    this.minPrice,
    this.durationText,
    this.speciality,
    this.availability,
    this.hasConsultation,
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
    this.enquiries,
    this.url,
    this.filename,
    this.mimeType,
    this.filesize,
    this.width,
    this.height,
    this.services,
    this.doctors,
    this.basePrice,
    this.isActive,
    this.price,
    this.duration,
    this.minGuests,
    this.maxGuests,
    this.availableDates,
    this.bookingNumber
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

    EnquiriesModel? enquiriesModel;
    if (json['enquiries'] is Map<String, dynamic>) {
      enquiriesModel = EnquiriesModel.fromJson(
        json['enquiries'] as Map<String, dynamic>,
      );
    }


    ManagedBy? managedBy;
    if (json['managedBy'] is Map<String, dynamic>) {
      managedBy = ManagedBy.fromJson(
        json['managedBy'] as Map<String, dynamic>,
      );
    }


    List<AssignedDoctor>? assignedDoctor;
    if (json['assignedDoctor'] is List) {
      assignedDoctor = (json['assignedDoctor'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => AssignedDoctor.fromJson(e))
          .toList();
    }

    List<PackagesModel>? packages;
    if (json['packages'] is List) {
      packages = (json['packages'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => PackagesModel.fromJson(e))
          .toList();
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

    List<ServiceModel>? services;
    if (json['services'] is List) {
      services = (json['services'] as List).map((e) {
        if (e is int) {
          return ServiceModel(id: e);
        } else if (e is Map<String, dynamic>) {
          return ServiceModel.fromJson(e);
        }
        throw Exception('Invalid service format');
      }).toList();
    }

    List<DoctorModel>? doctors;
    if (json['doctors'] is List) {
      doctors = (json['doctors'] as List).map((e) {
        if (e is int) {
          return DoctorModel(id: e);
        } else if (e is Map<String, dynamic>) {
          return DoctorModel.fromJson(e);
        }
        throw Exception('Invalid doctor format');
      }).toList();
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

    final center = json['center'];

    if (center is Map<String, dynamic>) {
      centerModel = CentreModel.fromJson(center);
    } else if (center is num) {
      centerModel = CentreModel(id: center.toInt());
    } else if (center is String) {
      final id = int.tryParse(center);
      if (id != null) {
        centerModel = CentreModel(id: id);
      }
    }

    PackagesModel? packageModel;
    if (json['package'] is Map<String, dynamic>) {
      packageModel = PackagesModel.fromJson(
        json['package'] as Map<String, dynamic>,
      );
    }

    final requirementsMap = json['requirements'];

    List<GuestsModel>? guestsList;
    if (requirementsMap is Map<String, dynamic> &&
        requirementsMap['guestDetails'] is List) {
      guestsList = [];
      for (var item in (requirementsMap['guestDetails'] as List)) {
        if (item is Map<String, dynamic>) {
          final ageVal = item['age'];
          int? parsedAge;
          if (ageVal is num) {
            parsedAge = ageVal.toInt();
          } else if (ageVal is String) {
            parsedAge = int.tryParse(ageVal);
          }
          guestsList.add(
            GuestsModel(
              id: item['id']?.toString(),
              fullName: item['name'] as String?,
              age: parsedAge,
              gender: item['gender'] as String?,
            ),
          );
        }
      }
    } else if (json['guests'] is List) {
      guestsList = (json['guests'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => GuestsModel.fromJson(e))
          .toList();
    }

    String? startDateVal = json['startDate'] as String?;
    int? groupSizeVal = parseInt(json['groupSize']);
    String? messageVal = json['message'] as String?;
    List<String>? wellnessGoalsVal = wellnessGoalsList;

    if (requirementsMap is Map<String, dynamic>) {
      if (requirementsMap['preferredDate'] != null) {
        startDateVal = requirementsMap['preferredDate'] as String?;
      }
      if (requirementsMap['groupSize'] != null) {
        groupSizeVal = parseInt(requirementsMap['groupSize']);
      }
      if (requirementsMap['concern'] != null) {
        messageVal = requirementsMap['concern'] as String?;
      }
      if (requirementsMap['wellnessGoals'] is List) {
        wellnessGoalsVal = (requirementsMap['wellnessGoals'] as List)
            .map((e) => e.toString())
            .toList();
      }
    }

    List<AvailableDatesModel>? availableDatesList;
    if (json['availableDates'] is List) {
      availableDatesList = (json['availableDates'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => AvailableDatesModel.fromJson(e))
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
      managedBy: managedBy,
      status: json['status'] as String?,
      onboardingCompleted: json['onboardingCompleted'] is bool
          ? json['onboardingCompleted'] as bool
          : null,
      dateOfBirth: json['dateOfBirth'],
      age: parseInt(json['age']),
      gender: json['gender'] as String?,
      wellnessGoals: wellnessGoalsVal,
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
      message: messageVal,
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
      startDate: startDateVal,
      slotTime: json['slotTime'],
      assignedDoctor: assignedDoctor,
      groupSize: groupSizeVal,
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
      isSaved: json['isSaved'],
      url: json['url'],
      filename: json['filename'],
      mimeType: json['mimeType'],
      filesize: json['filesize'],
      width: json['width'],
      height: json['height'],
      enquiries: enquiriesModel,
      doctors: doctors,
      services: services,
      packages: packages,
      basePrice: json['basePrice'],
      isActive: json['isActive'],
      bookingNumber: json['bookingNumber'],
      price: parseInt(json['price']),
      duration: parseInt(json['duration']),
      minGuests: parseInt(json['minGuests']),
      maxGuests: parseInt(json['maxGuests']),
      availableDates: availableDatesList,
      hasConsultation: json['hasConsultation'],
    )..reviews = reviewsModel;
  }

  Map<String, dynamic> toJson() => _$DocModelToJson(this);
}
