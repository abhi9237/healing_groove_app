import 'dart:developer';
import 'package:get/get.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/login_response_model.dart';
import 'package:healing/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  Future<bool> refreshToken() async {
    try {
      log('AuthController: refreshToken started');
      final response = await _authRepository.refreshToken();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = LogInResponseModel.fromJson(response.data);
        if (data.token != null) {
          await HiveStorageService.storeUserToken(data.token!);
          if (data.exp != null) {
            await HiveStorageService.storeTokenExpiry(data.exp!);
          }
          if (data.refreshToken != null && data.refreshToken!.isNotEmpty) {
            await HiveStorageService.storeRefreshToken(data.refreshToken!);
          }
          log('AuthController: Token refreshed successfully');
          return true;
        }
      }
      log('AuthController: Token refresh failed with status ${response.statusCode}');
      return false;
    } catch (e) {
      log('AuthController: Error refreshing token: $e');
      return false;
    }
  }
}
