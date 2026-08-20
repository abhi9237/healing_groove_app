import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class WellnessSettingsRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getCenterDetails(int centerId) async {
    log('WellnessSettingsRepository: API getCenterDetails initiated');
    log('WellnessSettingsRepository: Endpoint is ${ApiConstant.getCentersDetail}$centerId');

    try {
      final response = await _apiCall.getRequest(
        endPoint: '${ApiConstant.getCentersDetail}$centerId',
        token: HiveStorageService.getUserToken(),
      );
      log('WellnessSettingsRepository: getCenterDetails response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('WellnessSettingsRepository: getCenterDetails failed with error: $error');
      rethrow;
    }
  }

  Future<Response> updateCenterDetails(int centerId, Map<String, dynamic> data) async {
    log('WellnessSettingsRepository: API updateCenterDetails initiated');
    log('WellnessSettingsRepository: Endpoint is ${ApiConstant.getCentersDetail}$centerId');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: '${ApiConstant.getCentersDetail}$centerId',
        data: data,
        token: HiveStorageService.getUserToken(),
      );
      log('WellnessSettingsRepository: updateCenterDetails response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('WellnessSettingsRepository: updateCenterDetails failed with error: $error');
      rethrow;
    }
  }

  Future<Response> uploadImage({
    required File imageFile,
    required String centerName,
  }) async {
    log('WellnessSettingsRepository: API uploadImage initiated');
    log('WellnessSettingsRepository: Endpoint is ${ApiConstant.uploadImage}');

    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
        "alt": "$centerName — media image",
      });

      final response = await _apiCall.postMultipartRequest(
        endPoint: ApiConstant.uploadImage,
        data: formData,
        token: HiveStorageService.getUserToken(),
      );
      log('WellnessSettingsRepository: uploadImage response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('WellnessSettingsRepository: uploadImage failed with error: $error');
      rethrow;
    }
  }
}
