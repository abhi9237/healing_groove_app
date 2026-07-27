// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedCentreResponseModel _$SavedCentreResponseModelFromJson(
  Map<String, dynamic> json,
) => SavedCentreResponseModel(
  success: json['success'] as bool?,
  action: json['action'] as String?,
  savedCenters: (json['savedCenters'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$SavedCentreResponseModelToJson(
  SavedCentreResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'action': instance.action,
  'savedCenters': instance.savedCenters,
};
