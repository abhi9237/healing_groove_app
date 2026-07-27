// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestsModel _$GuestsModelFromJson(Map<String, dynamic> json) => GuestsModel(
  id: json['id'] as String?,
  fullName: json['fullName'] as String?,
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$GuestsModelToJson(GuestsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'age': instance.age,
      'gender': instance.gender,
    };
