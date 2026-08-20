import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class BookingManagementRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getCentreBookings({required int page, required int limit}) async {
    log('BookingManagementRepository: API getCentreBookings initiated');
    final String endPoint = '${ApiConstant.centreBookings}?depth=2&limit=$limit&page=$page&sort=-createdAt';
    log('BookingManagementRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('BookingManagementRepository: getCentreBookings response status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('BookingManagementRepository: getCentreBookings failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getBookingDetails(String bookingId) async {
    log('BookingManagementRepository: API getBookingDetails initiated');
    final String endPoint = '${ApiConstant.centreBookings}/$bookingId?depth=2';
    log('BookingManagementRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('BookingManagementRepository: getBookingDetails response status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('BookingManagementRepository: getBookingDetails failed with error: $error');
      rethrow;
    }
  }

  Future<Response> updateBookingStatus({required String bookingId, required Map<String, dynamic> data}) async {
    log('BookingManagementRepository: API updateBookingStatus initiated');
    final String endPoint = '${ApiConstant.centreBookings}/$bookingId';
    log('BookingManagementRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
        data: data,
      );
      log('BookingManagementRepository: updateBookingStatus response status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('BookingManagementRepository: updateBookingStatus failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getDoctors({required String userId}) async {
    log('BookingManagementRepository: API getDoctors initiated');
    final String endPoint = '${ApiConstant.getDoctors}?where[role][equals]=doctor&where=$userId&limit=500';
    log('BookingManagementRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('BookingManagementRepository: getDoctors response status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('BookingManagementRepository: getDoctors failed with error: $error');
      rethrow;
    }
  }
}

