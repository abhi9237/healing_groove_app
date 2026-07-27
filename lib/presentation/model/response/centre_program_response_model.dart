import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/common/meta_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';
import 'package:healing/presentation/model/common/service_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/doctor_model.dart';
part 'centre_program_response_model.g.dart';

@JsonSerializable()
class CenterProgramResponseModel {
  int? centerId;
  List<PackagesModel>? packages;

  MetaModel? meta;

  CenterProgramResponseModel({this.centerId, this.packages, this.meta});

  factory CenterProgramResponseModel.fromJson(Map<String, dynamic> json) {
    int? parsedCenterId = parseInt(json['centerId'] ?? json['center'] ?? json['id']);

    List<PackagesModel>? packagesList;
    if (json['packages'] is List) {
      packagesList = (json['packages'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => PackagesModel.fromJson(e))
          .toList();
    } else if (json['docs'] is List) {
      packagesList = (json['docs'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => PackagesModel.fromJson(e))
          .toList();
    } else if (json['data'] is List) {
      packagesList = (json['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => PackagesModel.fromJson(e))
          .toList();
    }

    MetaModel? metaModel;
    if (json['meta'] is Map<String, dynamic>) {
      metaModel = MetaModel.fromJson(json['meta'] as Map<String, dynamic>);
    }

    return CenterProgramResponseModel(
      centerId: parsedCenterId,
      packages: packagesList,
      meta: metaModel,
    );
  }

  Map<String, dynamic> toJson() => _$CenterProgramResponseModelToJson(this);
}
