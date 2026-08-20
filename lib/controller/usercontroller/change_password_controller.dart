import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/repository/settings_repository.dart';

class ChangePasswordController extends GetxController {
  final SettingsRepository _settingsRepository = SettingsRepository();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  RxBool isLoading = false.obs;

  void toggleOldPasswordObscure() {
    obscureOldPassword = !obscureOldPassword;
    update();
  }

  void toggleNewPasswordObscure() {
    obscureNewPassword = !obscureNewPassword;
    update();
  }

  void toggleConfirmPasswordObscure() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  Future<void> changePassword(BuildContext context) async {
    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter old password',
        context: context,
        isError: true,
      );
      return;
    }

    if (newPassword.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter new password',
        context: context,
        isError: true,
      );
      return;
    }

    if (newPassword.length < 6) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Password must be at least 6 characters long',
        context: context,
        isError: true,
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please confirm your new password',
        context: context,
        isError: true,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Passwords do not match',
        context: context,
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    update();

    try {
      final response = await _settingsRepository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'Password changed successfully!',
            context: context,
            isError: false,
          );
          context.pop();
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(response.data);
        final errorMessage = errorResponse.errors?.first.message ?? 'Failed to change password';
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorMessage,
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('ChangePasswordController: Error changing password: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'An error occurred. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
