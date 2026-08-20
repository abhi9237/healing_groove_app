import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:json_annotation/json_annotation.dart';

import 'guest_details_model.dart';
part 'enquiries_model.g.dart';

@JsonSerializable()
class EnquiriesModel {
  String? concern;
  List<String>? wellnessGoals;
  int? groupSize;
  String? preferredDate;
  List<GuestsDetailsModel>? guestDetails;
  String? stayDuration;
  String? preferredContact;
  String? budgetComfort;
  EnquiriesModel({this.concern, this.wellnessGoals, this.groupSize, this.preferredDate, this.guestDetails, this.stayDuration, this.preferredContact, this.budgetComfort});

  factory EnquiriesModel.fromJson(Map<String, dynamic> json) =>
      _$EnquiriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiriesModelToJson(this);
}
