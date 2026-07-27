// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocModel _$DocModelFromJson(Map<String, dynamic> json) => DocModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  amenities: (json['amenities'] as List<dynamic>?)
      ?.map((e) => AmenitiesModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  country: json['country'] as String?,
  role: json['role'] as String?,
  managedBy: json['managedBy'],
  status: json['status'] as String?,
  onboardingCompleted: json['onboardingCompleted'] as bool?,
  dateOfBirth: json['dateOfBirth'],
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  wellnessGoals: (json['wellnessGoals'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  preferredActivities: (json['preferredActivities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  savedCenters: (json['savedCenters'] as List<dynamic>?)
      ?.map((e) => SavedCentersModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  specialization: json['specialization'],
  qualification: json['qualification'],
  experienceYears: json['experienceYears'],
  consultationFee: json['consultationFee'],
  updatedAt: json['updatedAt'] as String?,
  createdAt: json['createdAt'] as String?,
  isSaved: json['isSaved'] as bool?,
  email: json['email'] as String?,
  description: json['description'] as String?,
  location: json['location'] == null
      ? null
      : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  admin: (json['admin'] as num?)?.toInt(),
  image: json['image'] == null
      ? null
      : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
  rating: (json['rating'] as num?)?.toInt(),
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  minPrice: (json['minPrice'] as num?)?.toInt(),
  durationText: json['durationText'] as String?,
  speciality: json['speciality'] as String?,
  availability: json['availability'] as String?,
  gallery: (json['gallery'] as List<dynamic>?)
      ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
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
  subject: json['subject'] as String?,
  message: json['message'] as String?,
  sourceType: json['sourceType'] as String?,
  response: json['response'],
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  userId: (json['userId'] as num?)?.toInt(),
  authorName: json['authorName'] as String?,
  centerId: (json['centerId'] as num?)?.toInt(),
  bookingId: (json['bookingId'] as num?)?.toInt(),
  text: json['text'] as String?,
  center: json['center'] == null
      ? null
      : CentreModel.fromJson(json['center'] as Map<String, dynamic>),
  package: json['package'] == null
      ? null
      : PackagesModel.fromJson(json['package'] as Map<String, dynamic>),
  startDate: json['startDate'] as String?,
  slotTime: json['slotTime'],
  assignedDoctor: json['assignedDoctor'] as List<dynamic>?,
  groupSize: (json['groupSize'] as num?)?.toInt(),
  guests: (json['guests'] as List<dynamic>?)
      ?.map((e) => GuestsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviews: json['reviews'] == null
      ? null
      : ReviewsModel.fromJson(json['reviews'] as Map<String, dynamic>),
  chargeAmount: (json['chargeAmount'] as num?)?.toInt(),
  chargeCurrency: json['chargeCurrency'] as String?,
  totalAmount: (json['totalAmount'] as num?)?.toInt(),
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
);

Map<String, dynamic> _$DocModelToJson(DocModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'name': instance.name,
  'description': instance.description,
  'phone': instance.phone,
  'country': instance.country,
  'admin': instance.admin,
  'rating': instance.rating,
  'image': instance.image,
  'role': instance.role,
  'managedBy': instance.managedBy,
  'status': instance.status,
  'onboardingCompleted': instance.onboardingCompleted,
  'dateOfBirth': instance.dateOfBirth,
  'age': instance.age,
  'gender': instance.gender,
  'wellnessGoals': instance.wellnessGoals,
  'preferredActivities': instance.preferredActivities,
  'savedCenters': instance.savedCenters,
  'specialization': instance.specialization,
  'qualification': instance.qualification,
  'experienceYears': instance.experienceYears,
  'consultationFee': instance.consultationFee,
  'updatedAt': instance.updatedAt,
  'createdAt': instance.createdAt,
  'email': instance.email,
  'sessions': instance.sessions,
  'location': instance.location,
  'reviewCount': instance.reviewCount,
  'minPrice': instance.minPrice,
  'durationText': instance.durationText,
  'speciality': instance.speciality,
  'availability': instance.availability,
  'gallery': instance.gallery,
  'approvalStatus': instance.approvalStatus,
  'capacity': instance.capacity,
  'numberOfRooms': instance.numberOfRooms,
  'servicesOffered': instance.servicesOffered,
  'facilities': instance.facilities,
  'displayOrder': instance.displayOrder,
  'subject': instance.subject,
  'message': instance.message,
  'sourceType': instance.sourceType,
  'response': instance.response,
  'user': instance.user,
  'amenities': instance.amenities,
  'reviews': instance.reviews,
  'userId': instance.userId,
  'authorName': instance.authorName,
  'centerId': instance.centerId,
  'bookingId': instance.bookingId,
  'text': instance.text,
  'center': instance.center,
  'package': instance.package,
  'startDate': instance.startDate,
  'slotTime': instance.slotTime,
  'assignedDoctor': instance.assignedDoctor,
  'groupSize': instance.groupSize,
  'guests': instance.guests,
  'totalAmount': instance.totalAmount,
  'chargeAmount': instance.chargeAmount,
  'chargeCurrency': instance.chargeCurrency,
  'isSaved': instance.isSaved,
  'confirmedAt': instance.confirmedAt,
  'completedAt': instance.completedAt,
  'rejectedAt': instance.rejectedAt,
  'rejectionReason': instance.rejectionReason,
  'cancelledAt': instance.cancelledAt,
  'cancellationReason': instance.cancellationReason,
  'refundStatus': instance.refundStatus,
  'adminRefundNote': instance.adminRefundNote,
  'cancellationPolicyScenario': instance.cancellationPolicyScenario,
  'cancellationPolicyRule': instance.cancellationPolicyRule,
  'cancellationRefundPercent': instance.cancellationRefundPercent,
  'cancellationRefundAmount': instance.cancellationRefundAmount,
  'cancellationRejectedReason': instance.cancellationRejectedReason,
  'cancellationApprovedAt': instance.cancellationApprovedAt,
  'cancellationApprovedBy': instance.cancellationApprovedBy,
  'refundInitiatedAt': instance.refundInitiatedAt,
  'razorpayRefundId': instance.razorpayRefundId,
  'refundProcessedAt': instance.refundProcessedAt,
};
