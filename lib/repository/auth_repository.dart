import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/service/network/api_constant/api_constant.dart';
import 'package:healing/service/network/api_service.dart';


class AuthRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    log('AuthRepository: API Sign In initiated for email: $email');
    log('AuthRepository: Endpoint is ${ApiConstant.signIn}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.signIn,
        data: {'email': email, 'password': password},
      );

      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> sendOtp({required Map<String, dynamic> data}) async
  {
    log('AuthRepository: API Send OTP initiated for email: $data');
    log('AuthRepository: Endpoint is ${ApiConstant.sendOtp}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.sendOtp,
        data: data,
      );
      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> reSendOtp({required Map<String, dynamic> data}) async
  {
    log('AuthRepository: API Send OTP initiated for email: $data');
    log('AuthRepository: Endpoint is ${ApiConstant.resendOtp}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.resendOtp,
        data: data,
      );
      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> createAccount({
    required Map<String, dynamic> data,
    required String id,
  }) async
  {
    log('AuthRepository: API Create Account initiated for email: $data');
    log('AuthRepository: Endpoint is ${ApiConstant.createAccount}');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: '${ApiConstant.createAccount}$id',
        data: data,
        token: HiveStorageService.getUserToken(),
      );
      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> verifyOtp({required Map<String, dynamic> data}) async {
    log('AuthRepository: API Verify OTP initiated for email: $data');
    log('AuthRepository: Endpoint is ${ApiConstant.verifyOtp}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.verifyOtp,
        data: data,
      );
      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> resetPassword({required Map<String, dynamic> data}) async {
    log('AuthRepository: API Verify OTP initiated for email: $data');
    log('AuthRepository: Endpoint is ${ApiConstant.resetPassword}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.resetPassword,
        data: data,
      );
      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> refreshToken() async {
    log('AuthRepository: Endpoint is ${ApiConstant.refreshToken}');

    try {
      final token = HiveStorageService.getRefreshToken() ?? HiveStorageService.getUserToken();
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.refreshToken,
        token: token,
      );

      log(
        'AuthRepository: Sign In API call returned with status code: ${response.statusCode}',
      );
      log('AuthRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('AuthRepository: Sign In API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> getCentreStatus({int? centerId}) async {
    log('AuthRepository: API getCentreStatus initiated for centerId: $centerId');
    final String endPoint = centerId != null
        ? '${ApiConstant.centreStatus}/$centerId'
        : ApiConstant.centreStatus;
    log('AuthRepository: Endpoint is $endPoint');

    try {
      final response = await _apiCall.getRequest(
        endPoint: endPoint,
        token: HiveStorageService.getUserToken(),
      );
      log('AuthRepository: getCentreStatus response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('AuthRepository: getCentreStatus failed with error: $error');
      rethrow;
    }
  }
}
