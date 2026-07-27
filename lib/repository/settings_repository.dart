import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

import '../../service/network/api_constant/api_constant.dart';
import '../../service/network/api_service.dart';

class SettingsRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> logout() async {
    log('AuthRepository: Endpoint is ${ApiConstant.logout}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.logout,
        token: HiveStorageService.getUserToken(),
      );

      log(
        'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Logout API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> updateUserProfile(
    String id,
    Map<String, dynamic> data,
  ) async
  {
    log('AuthRepository: Endpoint is ${ApiConstant.updateUserProfile}$id');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: '${ApiConstant.updateUserProfile}$id',
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log(
        'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Logout API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> userProfile() async
  {
    log('SettingsRepository: Endpoint is ${ApiConstant.userMe}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: '${ApiConstant.userMe}?depth=1',
        token: HiveStorageService.getUserToken(),
      );

      log(
        'SettingsRepository: User Profile API call returned with status code: ${response.statusCode}',
      );
      log('SettingsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log(
        'SettingsRepository: User Profile API call failed with error: $error',
      );
      rethrow;
    }
  }

  Future<Response> helpAndSupport(Map<String, dynamic> data) async
  {
    log('AuthRepository: Endpoint is ${ApiConstant.helpAndSupport}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.helpAndSupport,
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log(
        'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Logout API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> recentEnquiries() async
  {
    log('AuthRepository: Endpoint is ${ApiConstant.helpAndSupport}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.helpAndSupport,
        token: HiveStorageService.getUserToken(),
      );

      log(
        'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Logout API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getSavedCentres() async {
    log('SettingsRepository: Endpoint is ${ApiConstant.getSaveCentre}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.getSaveCentre,
        token: HiveStorageService.getUserToken(),
      );

      log(
        'SettingsRepository: Get Saved Centres API call returned with status code: ${response.statusCode}',
      );
      log('SettingsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log(
        'SettingsRepository: Get Saved Centres API call failed with error: $error',
      );
      rethrow;
    }
  }
}
