import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class SupportRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> createSupportTicket(Map<String, dynamic> data) async {
    log('SupportRepository: Endpoint is ${ApiConstant.createSupportTicket}');
    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.createSupportTicket,
        token: HiveStorageService.getUserToken(),
        data: data,
      );
      log('SupportRepository: createSupportTicket API status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('SupportRepository: createSupportTicket API failed: $error');
      rethrow;
    }
  }

  Future<Response> getSupportTickets({required String email}) async {
    final String base = ApiConstant.helpAndSupport;
    final String endPoint = '$base?where[and][0][email][equals]=$email&where[and][1][sourceType][equals]=center&limit=10&sort=-createdAt';
    log('SupportRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('SupportRepository: getSupportTickets API status: ${response.statusCode}');
      return response;
    } catch (error) {
      log('SupportRepository: getSupportTickets API failed: $error');
      rethrow;
    }
  }
}
