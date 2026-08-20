import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/repository/auth_repository.dart';

import '../../presentation/model/response/error_response_model.dart';
import '../../presentation/model/response/send_otp_response_model.dart';
import '../../presentation/model/response/verify_otp_response.dart';

class ForgotPasswordController extends GetxController {
  int stepIndex = 0; // 0: Email Input, 1: OTP verification, 2: Reset password form
  RxBool isLoading = false.obs;

  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String resetPasswordToken = '';

  Timer? _timer;
  int timerSeconds = 30;

  void startTimer() {
    _timer?.cancel();
    timerSeconds = 30;
    update();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        timerSeconds--;
        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  void navigateBackStep(BuildContext context) {
    _timer?.cancel();
    if (stepIndex == 2) {
      stepIndex = 0;
      update();
      return;
    }
    if (stepIndex > 0) {
      stepIndex--;
      update();
    } else {
      context.pop();
    }
  }

  Future<void> sendOtp(BuildContext context) async {
    final String email = emailController.text.trim();
    if (email.isEmpty || !isValidEmail(email)) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid email address',
        context: context,
        isError: true,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();
      var response = await _authRepository.sendOtp(
        data: {
          'email': email,
          'purpose': 'reset_password',
        },
      );
      if (response.statusCode == 200) {
        SendOtpResponse sendOtpResponse = SendOtpResponse.fromJson(
          response.data,
        );
        stepIndex = 1;
        startTimer();
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: sendOtpResponse.message ?? 'Verification OTP sent successfully',
            context: context,
            isError: false,
          );
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? 'Failed to send OTP',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error sending OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to send OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    final String otp = otpController.text.trim();
    if (otp.isEmpty || otp.length < 4) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid verification code',
        context: context,
        isError: true,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();
      var response = await _authRepository.verifyOtp(
        data: {
          'otp': otp,
          'email': emailController.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        VerifyOtpResponse verifyOtpResponse = VerifyOtpResponse.fromJson(
          response.data,
        );
        resetPasswordToken = verifyOtpResponse.resetToken ?? '';
        stepIndex = 2; // Transition to password reset screen
        _timer?.cancel();
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'OTP verified successfully',
            context: context,
            isError: false,
          );
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? 'Failed to verify OTP',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error verifying OTP: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to verify OTP. Please try again.',
          context: context,
          isError: true,
        );
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    final String email = emailController.text.trim();
    final String newPassword = newPasswordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || !isValidEmail(email)) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid email address',
        context: context,
        isError: true,
      );
      return;
    }

    if (newPassword.isEmpty || newPassword.length < 6) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Password must be at least 6 characters long',
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

    try {
      isLoading.value = true;
      update();
      var response = await _authRepository.resetPassword(
        data: {
          'email': email,
          'resetToken': resetPasswordToken,
          'newPassword': newPassword,
        },
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Success',
            message: 'Password reset successfully',
            context: context,
            isError: false,
          );
          context.go(RouteConstant.login);
        }
      } else {
        ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
          response.data,
        );
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: errorResponse.errors?.first.message ?? 'Failed to reset password',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e) {
      log('Error resetting password: $e');
      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to reset password. Please try again.',
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
    _timer?.cancel();
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
