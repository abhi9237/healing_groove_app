import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'upload_image_response_model.g.dart';

@JsonSerializable()
class UploadImageModelResponse {
  DocModel? doc;

  UploadImageModelResponse({this.doc});

  factory UploadImageModelResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageModelResponseToJson(this);
}
