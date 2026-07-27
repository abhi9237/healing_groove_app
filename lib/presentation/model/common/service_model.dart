import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/centre_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  int? id;
  CentreModel? center;
  String? name;
  String? description;
  int? basePrice;
  List<dynamic>? seasons;
  bool? isActive;
  String? updatedAt;
  String? createdAt;
  ServiceModel({
    this.id,
    this.center,
    this.name,
    this.description,
    this.basePrice,
    this.seasons,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    CentreModel? centerModel;
    if (json['center'] is Map<String, dynamic>) {
      centerModel = CentreModel.fromJson(json['center'] as Map<String, dynamic>);
    }

    return ServiceModel(
      id: parseInt(json['id']),
      center: centerModel,
      name: json['name'] as String?,
      description: json['description'] as String?,
      basePrice: parseInt(json['basePrice']),
      seasons: json['seasons'] is List ? json['seasons'] as List<dynamic> : null,
      isActive: json['isActive'] is bool ? json['isActive'] as bool : null,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
