import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/presentation/model/response/login_response_model.dart';
import 'package:healing/presentation/model/response/centre_response_model.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../repository/auth_repository.dart';
import '../../repository/set_up_center_detail_repository.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  RxBool isSelectedRememberMe = false.obs;
  RxBool isShowPassword = true.obs;
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

  Future<void> onTapSignIn(BuildContext context) async {
    if (emailController.value.text.trim().isEmpty ||
        !isValidEmail(emailController.value.text.trim())) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter a valid email.',
        context: context,
        isError: true,
      );
      return;
    }

    if (passwordController.value.text.trim().isEmpty) {
      showToastMessage(
        titleMessage: 'Error',
        message: 'Please enter your password.',
        context: context,
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    update();

    try {
      final response = await _authRepository.signIn(
        email: emailController.value.text.trim(),
        password: passwordController.value.text.trim(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LogInResponseModel.fromJson(response.data);

        HiveStorageService.storeUserToken(loginResponse.token ?? '');
        HiveStorageService.storeOnboardingComplete(
          loginResponse.user?.onboardingCompleted ?? false,
        );
        HiveStorageService.storeUserId(loginResponse.user?.id.toString() ?? '');
        HiveStorageService.storeUserType(loginResponse.user?.role ?? '');
        HiveStorageService.storeTokenExpiry(loginResponse.exp ?? 0);
        HiveStorageService.storeUserEmail(loginResponse.user?.email ?? '');
        HiveStorageService.storeUserName(loginResponse.user?.name ?? '');
        if (loginResponse.refreshToken != null &&
            loginResponse.refreshToken!.isNotEmpty) {
          await HiveStorageService.storeRefreshToken(
            loginResponse.refreshToken!,
          );
        }

        HiveStorageService.storeRememberMe(isSelectedRememberMe.value);
        HiveStorageService.storeCenterId(loginResponse.user?.centerId);

        // Stop loader before navigation
        isLoading.value = false;
        update();

        if (!context.mounted) return;

        if (loginResponse.user?.onboardingCompleted == false &&
            loginResponse.user?.role == 'user') {
          context.go(
            RouteConstant.tellUsAboutYourself,
            extra: {'comingFrom': 'login'},
          );
        } else if (loginResponse.user?.role == 'center_admin') {
          if (loginResponse.user?.onboardingCompleted == false) {
            context.go(RouteConstant.setUpYourCentre);
          } else {
            final localStatus = HiveStorageService.getWellnessApprovalStatus();
            if (localStatus == 'approved') {
              context.go(RouteConstant.wellnessDashboard);
            } else {
              try {
                final statusResponse = await _authRepository.getCentreStatus(
                  centerId: loginResponse.user?.centerId,
                );
                if (statusResponse.statusCode == 200 &&
                    statusResponse.data != null) {
                  final Map<String, dynamic> responseData =
                      statusResponse.data as Map<String, dynamic>;
                  final parsedCentre = responseData.containsKey('doc')
                      ? CentreResponseModel.fromJson(responseData)
                      : CentreResponseModel(
                          doc: DocModel.fromJson(responseData),
                        );
                  final approvalStatus =
                      parsedCentre.doc?.approvalStatus ?? 'pending';
                  await HiveStorageService.storeWellnessApprovalStatus(
                    approvalStatus,
                  );

                  if (!context.mounted) return;
                  if (approvalStatus == 'approved') {
                    context.go(RouteConstant.wellnessDashboard);
                  } else {
                    context.go(
                      RouteConstant.centreUnderReview,
                      extra: parsedCentre,
                    );
                  }
                } else {
                  if (context.mounted) {
                    context.go(RouteConstant.centreUnderReview);
                  }
                }
              } catch (e) {
                log("Error fetching center status during login: $e");
                if (context.mounted) {
                  context.go(RouteConstant.centreUnderReview);
                }
              }
            }
          }
        } else {
          context.go(RouteConstant.userDashboard);
        }
      } else {
        // Stop loader before showing error
        isLoading.value = false;
        update();

        final errorResponse = ErrorResponseModel.fromJson(response.data);

        if (context.mounted) {
          showToastMessage(
            titleMessage: 'Error',
            message:
                errorResponse.errors?.first.message ?? 'Something went wrong.',
            context: context,
            isError: true,
          );
        }
      }
    } catch (e, stackTrace) {
      log("SignIn Error: $e");
      log(stackTrace.toString());

      // Stop loader before showing error
      isLoading.value = false;
      update();

      if (context.mounted) {
        showToastMessage(
          titleMessage: 'Error',
          message: 'Failed to sign in. Please try again.',
          context: context,
          isError: true,
        );
      }
    }
  }
}
