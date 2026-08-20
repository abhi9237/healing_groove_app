import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class DoctorRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> createDoctor(Map<String, dynamic> data) async {
    log('DoctorRepository: Endpoint is ${ApiConstant.addDoctor}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.addDoctor,
        token: HiveStorageService.getUserToken(),
        data: data,
      );

      log(
        'DoctorRepository: Create Doctor API call returned with status code: ${response.statusCode}',
      );
      log('DoctorRepository: Response data: ${response.data}');
      return response;
    } catch (error) {
      log('DoctorRepository: Create Doctor API call failed with error: $error');
      rethrow;
    }
  }


}

