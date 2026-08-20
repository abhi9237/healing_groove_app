import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../core/storage/hive_storage_service.dart';
import '../service/network/api_constant/api_constant.dart';
import '../service/network/api_service.dart';

class AddNewProgramRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Response> uploadImage({
    required File imageFile,
    required String programName,
  }) async {
    log('AddNewProgramRepository: API uploadImage initiated');
    log('AddNewProgramRepository: Endpoint is ${ApiConstant.uploadImage}');

    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
        "alt": "$programName — program image",
      });

      final response = await _apiCall.postMultipartRequest(
        endPoint: ApiConstant.uploadImage,
        data: formData,
        token: HiveStorageService.getUserToken(),
      );
      log('AddNewProgramRepository: uploadImage response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('AddNewProgramRepository: uploadImage failed with error: $error');
      rethrow;
    }
  }

  Future<Response> addProgram({
    required Map<String, dynamic> data,
  }) async {
    log('AddNewProgramRepository: API addProgram initiated');
    log('AddNewProgramRepository: Endpoint is ${ApiConstant.centreProgram}');

    try {
      final response = await _apiCall.postRequest(
        endPoint: ApiConstant.createPrograms,
        data: data,
        token: HiveStorageService.getUserToken(),
      );
      log('AddNewProgramRepository: addProgram response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('AddNewProgramRepository: addProgram failed with error: $error');
      rethrow;
    }
  }

  Future<Response> updateProgram({
    required int programId,
    required Map<String, dynamic> data,
  }) async {
    log('AddNewProgramRepository: API updateProgram initiated');
    log('AddNewProgramRepository: Endpoint is ${ApiConstant.updatePrograms}$programId');

    try {
      final response = await _apiCall.patchRequest(
        endPoint: '${ApiConstant.updatePrograms}$programId',
        data: data,
        token: HiveStorageService.getUserToken(),
      );
      log('AddNewProgramRepository: updateProgram response status code: ${response.statusCode}');
      return response;
    } catch (error) {
      log('AddNewProgramRepository: updateProgram failed with error: $error');
      rethrow;
    }
  }
}
