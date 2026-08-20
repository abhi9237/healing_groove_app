import 'dart:developer';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_service.dart';
import '../service/network/api_constant/api_constant.dart';

class ProgramAndPackagesRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> getPrograms({required int centerId}) async {
    log('ProgramAndPackagesRepository: Endpoint is ${ApiConstant.getPrograms}');

    try {
      final response = await _apiCall.getRequest(
        endPoint: ApiConstant.getPrograms,
        token: HiveStorageService.getUserToken(),
        queryParameters: {
          'where[center][equals]': centerId,
          // 'limit': 100,
          // 'depth': 1,
        },
      );

      log('ProgramAndPackagesRepository: getPrograms API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ProgramAndPackagesRepository: getPrograms API call failed with error: $error');
      rethrow;
    }
  }

  Future<Response> deleteProgram(int programId) async {
    log('ProgramAndPackagesRepository: Endpoint is ${ApiConstant.deleteProgram}$programId');

    try {
      final response = await _apiCall.deleteRequest(
        endPoint: '${ApiConstant.deleteProgram}$programId',
        token: HiveStorageService.getUserToken(),
      );

      log('ProgramAndPackagesRepository: deleteProgram API call returned with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('ProgramAndPackagesRepository: deleteProgram API call failed with error: $error');
      rethrow;
    }
  }
}
