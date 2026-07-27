import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/storage/hive_storage_service.dart';
import '../../service/network/api_constant/api_constant.dart';
import '../../service/network/api_service.dart';

class ViewDetailRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getCentersDetail(int id) async {
    log('SettingsRepository: Endpoint is ${ApiConstant.getCenters}/$id');

    try {
      final response = await _apiCall.getRequest(
        endPoint: "${ApiConstant.getCentersDetail}$id",
        token: HiveStorageService.getUserToken(),
      );

      log(
        'SettingsRepository: User Profile API call returned with status code: ${response.statusCode}',
      );
      log('SettingsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('SettingsRepository: User Profile API call failed with error: $error');
      rethrow;
    }
  }
  Future<Response> getCentersProgramDetail(int id) async {
    log('SettingsRepository: Endpoint is ${ApiConstant.centreProgram}/$id');

    try {
      final response = await _apiCall.getRequest(
        endPoint: "${ApiConstant.centreProgram}$id",
        token: HiveStorageService.getUserToken(),
      );

      log(
        'SettingsRepository: User Profile API call returned with status code: ${response.statusCode}',
      );
      log('SettingsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('SettingsRepository: User Profile API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> saveCentre(Map<String, dynamic> data) async {
    log('SettingsRepository: Endpoint is ${ApiConstant.saveCentre}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.saveCentre,
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log(
        'SettingsRepository: Save Centre API call returned with status code: ${response.statusCode}',
      );
      log('SettingsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('SettingsRepository: Save Centre API call failed with error: $error');
      rethrow;
    }
  }
}