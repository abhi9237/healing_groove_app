import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_service.dart';
import '../service/network/api_constant/api_constant.dart';

class ServicesRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getServices({required int centerId, int limit = 200}) async {
    log('ServicesRepository: Endpoint is ${ApiConstant.centreServices}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.centreServices,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'limit': limit,
          'where[center][equals]': centerId,
        },
      );

      log('ServicesRepository: getServices API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ServicesRepository: getServices API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> createCentreService(Map<String, dynamic> data) async {
    log('ServicesRepository: Endpoint is ${ApiConstant.centreServices}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.centreServices,
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log('ServicesRepository: createCentreService API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ServicesRepository: createCentreService API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> updateCentreService(int serviceId, Map<String, dynamic> data) async {
    log('ServicesRepository: Endpoint is ${ApiConstant.centreServices}/$serviceId');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: '${ApiConstant.centreServices}/$serviceId',
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log('ServicesRepository: updateCentreService API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ServicesRepository: updateCentreService API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> deleteCentreService(int serviceId) async {
    log('ServicesRepository: Endpoint is ${ApiConstant.centreServices}/$serviceId');

    try {
      final response = await _apiCall.deleteRequest(
        endPoint: '${ApiConstant.centreServices}/$serviceId',
        token: HiveStorageService.getUserToken(),
      );

      log('ServicesRepository: deleteCentreService API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ServicesRepository: deleteCentreService API call failed with error: $error');
      rethrow;
    }
  }
}