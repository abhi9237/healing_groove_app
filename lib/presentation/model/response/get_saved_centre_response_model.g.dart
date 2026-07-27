// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_saved_centre_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSavedCentreResponseModel _$GetSavedCentreResponseModelFromJson(
  Map<String, dynamic> json,
) => GetSavedCentreResponseModel(
  success: json['success'] as bool?,
  savedCenters: (json['savedCenters'] as List<dynamic>?)
      ?.map((e) => SavedCentersModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetSavedCentreResponseModelToJson(
  GetSavedCentreResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'savedCenters': instance.savedCenters,
};
