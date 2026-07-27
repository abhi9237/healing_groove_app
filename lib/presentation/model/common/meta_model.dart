import 'package:json_annotation/json_annotation.dart';
part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel {
  int? packageCount;
  int? serviceCount;
  int? doctorCount;

  MetaModel({this.packageCount, this.serviceCount, this.doctorCount});

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}
