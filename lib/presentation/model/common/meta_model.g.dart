// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) => MetaModel(
  packageCount: (json['packageCount'] as num?)?.toInt(),
  serviceCount: (json['serviceCount'] as num?)?.toInt(),
  doctorCount: (json['doctorCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
  'packageCount': instance.packageCount,
  'serviceCount': instance.serviceCount,
  'doctorCount': instance.doctorCount,
};
