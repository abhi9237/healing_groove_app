import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  int? id;
  String? prefix;
  String? alt;
  String? updatedAt;
  String? createdAt;
  String? url;
  String? thumbnailURL;
  String? filename;
  String? mimeType;
  int? filesize;
  int? width;
  int? height;
  int? focalX;
  int? focalY;


  ImageModel({this.id,
    this.prefix,
    this.alt,
    this.updatedAt,
    this.createdAt,
    this.url,
    this.thumbnailURL,
    this.filename,
    this.mimeType,
    this.filesize,
    this.width,
    this.height,
    this.focalX,
    this.focalY});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
