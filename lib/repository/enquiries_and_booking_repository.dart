import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class EnquiriesAndBookingRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getEnquiriesAndBooking({int page = 1, int limit = 10}) async {
    log('AuthRepository: Endpoint is ${ApiConstant.getEnquiriesAndBookings}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.getEnquiriesAndBookings,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
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

  // Future<Response> createBooking(Map<String, dynamic> data) async {
  //   log('AuthRepository: Endpoint is ${ApiConstant.createBooking}');
  //
  //   try {
  //     final response = await _apiCall.postRequest(
  //       endPoint: ApiConstant.createBooking,
  //       token: HiveStorageService.getUserToken(),
  //       data: data,
  //     );
  //
  //     log(
  //       'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
  //     );
  //     log('AuthRepository: Response data: ${response.data}');
  //     return response;
  //   } catch (error) {
  //     log('AuthRepository: Logout API call failed with error: $error');
  //     rethrow;
  //   }
  // }
  //
  // Future<Response> createBookingOrder(Map<String, dynamic> data) async {
  //   log('AuthRepository: Endpoint is ${ApiConstant.createRazorPayOrder}');
  //
  //   try {
  //     final response = await _apiCall.postRequest(
  //       endPoint: ApiConstant.createRazorPayOrder,
  //       token: HiveStorageService.getUserToken(),
  //       data: data,
  //     );
  //
  //     log(
  //       'AuthRepository: Logout API call returned with status code: ${response.statusCode}',
  //     );
  //     log('AuthRepository: Response data: ${response.data}');
  //     return response;
  //   } catch (error) {
  //     log('AuthRepository: Logout API call failed with error: $error');
  //     rethrow;
  //   }
  // }
  //
  // Future<Response> verifyPayment(Map<String, dynamic> data) async {
  //   log('BookProgramRepository: Endpoint is ${ApiConstant.verifyRazorPay}');
  //
  //   try {
  //     final response = await _apiCall.postRequest(
  //       endPoint: ApiConstant.verifyRazorPay,
  //       token: HiveStorageService.getUserToken(),
  //       data: data,
  //     );
  //
  //     log(
  //       'BookProgramRepository: verifyPayment API call returned status code: ${response.statusCode}',
  //     );
  //     log('BookProgramRepository: Response data: ${response.data}');
  //     return response;
  //   } catch (error) {
  //     log('BookProgramRepository: verifyPayment API call failed with error: $error');
  //     rethrow;
  //   }
  // }
  //
  // Future<Response> requestCancellation(Map<String, dynamic> data) async {
  //   log('BookProgramRepository: Endpoint is ${ApiConstant.requestCancellation}');
  //
  //   try {
  //     final response = await _apiCall.postRequest(
  //       endPoint: ApiConstant.requestCancellation,
  //       token: HiveStorageService.getUserToken(),
  //       data: data,
  //     );
  //
  //     log(
  //       'BookProgramRepository: requestCancellation API call returned status code: ${response.statusCode}',
  //     );
  //     log('BookProgramRepository: Response data: ${response.data}');
  //     return response;
  //   } catch (error) {
  //     log('BookProgramRepository: requestCancellation API call failed with error: $error');
  //     rethrow;
  //   }
  // }
}
