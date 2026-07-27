import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class MyJourneyRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getBookings({int page = 1, int limit = 10}) async {
    log('MyJourneyRepository: Endpoint is ${ApiConstant.myBookings}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.myBookings,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      log(
        'MyJourneyRepository: getBookings API call returned with status code: ${response.statusCode}',
      );
      log('MyJourneyRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('MyJourneyRepository: getBookings API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getRefundPreview(int bookingId) async {
    log('MyJourneyRepository: Endpoint is ${ApiConstant.refundEnquiries}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.refundEnquiries,
        token: HiveStorageService.getUserToken(),
        data: {
          'bookingId': bookingId,
        },
      );

      log(
        'MyJourneyRepository: getRefundPreview API call returned status code: ${response.statusCode}',
      );
      log('MyJourneyRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('MyJourneyRepository: getRefundPreview API call failed with error: $error');
      rethrow;
    }
  }
}
