import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'preview_model.g.dart';

@JsonSerializable()
class PreviewModel {
  int? bookingId;
  String? bookingNumber;
  String? programName;
  String? bookingDate;
  String? programStartDate;
  String? cancellationDate;
  String? scenario;
  String? scenarioDescription;
  String? policyRule;
  int? refundPercent;
  int? refundAmount;
  bool? wellnessCreditEligible;
  int? wellnessCreditAmount;
  int? daysBookingToStart;
  int? daysBeforeStart;
  double? hoursBeforeStart;
  PreviewModel( {this.bookingId,
    this.bookingNumber,
    this.programName,
    this.bookingDate,
    this.programStartDate,
    this.cancellationDate,
    this.scenario,
    this.scenarioDescription,
    this.policyRule,
    this.refundPercent,
    this.refundAmount,
    this.wellnessCreditEligible,
    this.wellnessCreditAmount,
    this.daysBookingToStart,
    this.daysBeforeStart,
    this.hoursBeforeStart});

  factory PreviewModel.fromJson(Map<String, dynamic> json) =>
      _$PreviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewModelToJson(this);
}
