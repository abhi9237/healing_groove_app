import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/presentation/model/response/login_response_model.dart';
import '../repository/auth_repository.dart';


class LoginController extends GetxController {
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  RxBool isSelectedRememberMe = false.obs;
  RxBool isShowPassword = false.obs;
  RxBool isLoading = false.obs;

  final AuthRepository _authRepository = AuthRepository();

  void onTapSignUp(BuildContext context) {
    context.push(
      RouteConstant.createAccount,
      extra: {'isComingAuthSelection': false},
    );
  }

  void onTapRememberMe() {
    isSelectedRememberMe.value = !isSelectedRememberMe.value;
    update();
  }

  void onTapHidePassword() {
    isShowPassword.value = !isShowPassword.value;
    log('qq');
    update();
  }

  void onTapSignIn(BuildContext context) async {
    if (emailController.value.text.isEmpty ||
        !isValidEmail(emailController.value.text.trim())) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter valid email',
        context: context,
        isError: true,
      );
    } else if (passwordController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter valid password',
        context: context,
        isError: true,
      );
    } else {
      isLoading.value = true;
      update();
      try {
        final response = await _authRepository.signIn(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim(),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          LogInResponseModel loginResponse = LogInResponseModel.fromJson(
            response.data,
          );
          HiveStorageService.storeUserToken(loginResponse.token ?? '');
          HiveStorageService.storeUserId(
            loginResponse.user?.id.toString() ?? '',
          );
          HiveStorageService.storeUserType(loginResponse.user?.role ?? '');
          HiveStorageService.storeTokenExpiry(loginResponse.exp ?? 0);
          HiveStorageService.storeUserEmail(loginResponse.user?.email ?? '');
          HiveStorageService.storeUserName(loginResponse.user?.name ?? '');

          if (isSelectedRememberMe.value == true) {
            HiveStorageService.storeRememberMe(true);
          } else {
            HiveStorageService.storeRememberMe(false);
          }

          if (loginResponse.user?.onboardingCompleted == false) {
            if (context.mounted) {
              context.go(RouteConstant.tellUsAboutYourself);
            }
          } else {
            if (context.mounted) {
              context.go(RouteConstant.userDashboard);
            }
          }
        } else {
          ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(
            response.data,
          );
          if (context.mounted) {
            showToastMessage(
              titleMessage: 'Error',
              message: errorResponse.errors?.first.message ?? '',
              context: context,
              isError: true,
            );
          }
        }
      } catch (e) {
        log('Error $e');
        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message: 'Failed to sign in. Please check your network connection.',
            context: context,
            isError: true,
          );
        }
      } finally {
        isLoading.value = false;
        update();
      }
    }
  }
}
