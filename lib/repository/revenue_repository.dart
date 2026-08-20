import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class RevenueRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getRevenue({required int centerId}) async {
    log('RevenueRepository: API getRevenue initiated');
    // Using ApiConstant.getRevenue, if it has a trailing slash, we can clean/trim it or use it. Let's make sure it handles both.
    final String base = ApiConstant.getRevenue.endsWith('/') 
        ? ApiConstant.getRevenue.substring(0, ApiConstant.getRevenue.length - 1)
        : ApiConstant.getRevenue;
    final String endPoint = '$base?where[centerId][equals]=$centerId&limit=500';
    log('RevenueRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('RevenueRepository: getRevenue response status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('RevenueRepository: getRevenue failed with error: $error');
      rethrow;
    }
  }
}
