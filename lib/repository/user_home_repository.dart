import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/storage/hive_storage_service.dart';
import '../../service/network/api_constant/api_constant.dart';
import '../../service/network/api_service.dart';

class UserHomeRepository {
  final ApiCall _apiCall = ApiCall();


  Future<Response> getCenters({int page = 1, int limit = 10}) async {
    log('SettingsRepository: Endpoint is ${ApiConstant.getCenters}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.getCenters,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
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


}