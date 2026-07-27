// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
  id: (json['id'] as num?)?.toInt(),
  prefix: json['prefix'] as String?,
  alt: json['alt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  createdAt: json['createdAt'] as String?,
  url: json['url'] as String?,
  thumbnailURL: json['thumbnailURL'] as String?,
  filename: json['filename'] as String?,
  mimeType: json['mimeType'] as String?,
  filesize: (json['filesize'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  focalX: (json['focalX'] as num?)?.toInt(),
  focalY: (json['focalY'] as num?)?.toInt(),
);

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prefix': instance.prefix,
      'alt': instance.alt,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'url': instance.url,
      'thumbnailURL': instance.thumbnailURL,
      'filename': instance.filename,
      'mimeType': instance.mimeType,
      'filesize': instance.filesize,
      'width': instance.width,
      'height': instance.height,
      'focalX': instance.focalX,
      'focalY': instance.focalY,
    };
