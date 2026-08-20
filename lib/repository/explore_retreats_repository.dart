import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class ExploreRetreatsRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getCentrePackages({int page = 1, int limit = 500}) async {
    log('ExploreRetreatsRepository: Endpoint is ${ApiConstant.getPackages}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.getPackages,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      log(
        'ExploreRetreatsRepository: getCentrePackages API call returned with status code: ${response.statusCode}',
      );
      log('ExploreRetreatsRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('ExploreRetreatsRepository: getCentrePackages API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> searchCenters({
    String? q,
    String? destination,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 100,
  }) async {
    log('ExploreRetreatsRepository: Endpoint is ${ApiConstant.searchCenters}');
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (q != null && q.isNotEmpty) {
        queryParams['q'] = q;
      }
      if (destination != null && destination.isNotEmpty) {
        queryParams['destination'] = destination;
      }
      if (startDate != null && startDate.isNotEmpty) {
        queryParams['startDate'] = startDate;
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryParams['endDate'] = endDate;
      }

      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.searchCenters,
        token: HiveStorageService.getUserToken(),
        queryParameters: queryParams,
      );

      log('ExploreRetreatsRepository: searchCenters API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ExploreRetreatsRepository: searchCenters API call failed with error: $error');
      rethrow;
    }
  }

}