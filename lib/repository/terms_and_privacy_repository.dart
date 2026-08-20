import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class TermsAndPrivacyRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getTerms() async {
    log('TermsAndPrivacyRepository: Endpoint is ${ApiConstant.terms}');
    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.terms,
        token: HiveStorageService.getUserToken(),
      );
      log('TermsAndPrivacyRepository: getTerms returned status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('TermsAndPrivacyRepository: getTerms failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getPrivacyPolicy() async {
    log('TermsAndPrivacyRepository: Endpoint is ${ApiConstant.privacyPolicy}');
    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.privacyPolicy,
        token: HiveStorageService.getUserToken(),
      );
      log('TermsAndPrivacyRepository: getPrivacyPolicy returned status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('TermsAndPrivacyRepository: getPrivacyPolicy failed with error: $error');
      rethrow;
    }
  }
}
