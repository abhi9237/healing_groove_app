import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class SetUpCenterDetailRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> uploadImage({
    required File imageFile,
    required String centerName,
  }) async {
    log('SetUpCenterDetailRepository: API uploadImage initiated');
    log('SetUpCenterDetailRepository: Endpoint is ${ApiConstant.uploadImage}');

    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
        "alt": "$centerName — featured image",
      });
      log('SetUpCenterDetailRepository:formData $formData');

      final response = await _apiCall.postMultipartRequest(
        endPoint: ApiConstant.uploadImage,
        data: formData,
        token: HiveStorageService.getUserToken(),
      );
      log(
        'SetUpCenterDetailRepository: uploadImage response status code: ${response.statusCode}',
      );
      return response;
    } catch (error) {
      log('SetUpCenterDetailRepository: uploadImage failed with error: $error');
      rethrow;
    }
  }

  Future<Response> createCentre({
    required Map<String, dynamic> data,
  }) async {
    log('SetUpCenterDetailRepository: API createCentre initiated');
    log('SetUpCenterDetailRepository: Endpoint is ${ApiConstant.createCentre}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.createCentre,
        data: data,
        token: HiveStorageService.getUserToken(),
      );
      log('SetUpCenterDetailRepository: createCentre response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('SetUpCenterDetailRepository: createCentre failed with error: $error');
      rethrow;
    }
  }
}
