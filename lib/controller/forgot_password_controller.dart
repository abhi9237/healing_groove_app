import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

class ForgotPasswordController extends GetxController {
  int stepIndex =
      0; // 0: Email Input, 1: OTP verification, 2: Reset password form
  RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void navigateBackStep(BuildContext context) {
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

  void sendOtp(BuildContext context) async {
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

    isLoading.value = true;
    update();

    // Simulate OTP network request
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
    stepIndex = 1; // Transition to OTP screen
    update();

    if (context.mounted) {
      showToastMessage(
        titleMessage: 'Success',
        message: 'Verification OTP sent to $email',
        context: context,
        isError: false,
      );
    }
  }

  void verifyOtp(BuildContext context) async {
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

    isLoading.value = true;
    update();

    // Simulate OTP verification API call
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
    stepIndex = 2; // Transition to password reset screen
    update();

    if (context.mounted) {
      showToastMessage(
        titleMessage: 'Success',
        message: 'OTP verified successfully',
        context: context,
        isError: false,
      );
    }
  }

  void resetPassword(BuildContext context) async {
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

    isLoading.value = true;
    update();

    // Simulate password updates network call
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
    update();

    if (context.mounted) {
      showToastMessage(
        titleMessage: 'Success',
        message: 'Password reset successfully',
        context: context,
        isError: false,
      );
      context.go(RouteConstant.login);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
