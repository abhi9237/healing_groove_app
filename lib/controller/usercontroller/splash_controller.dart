import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

class SplashController extends GetxController {
  final BuildContext? context;

  SplashController({this.context});

  @override
  void onInit() {
    super.onInit();
    navigateToNextPage(context!);
  }

  Future<void> navigateToNextPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final token = HiveStorageService.getUserToken();
    final tokenExpiry = HiveStorageService.getTokenExpiry();
    final rememberMe = HiveStorageService.getRememberMe();
    final userType = HiveStorageService.getUserType();
    final onboardingComplete = HiveStorageService.getOnboardingComplete();

    if (token != null && rememberMe == true) {
      if (userType == 'user') {
        if (onboardingComplete == true) {
          if (context.mounted) {
            context.go(RouteConstant.userDashboard);
          }
        } else {
          if (context.mounted) {
            context.go(RouteConstant.onBoarding);
          }
        }
        return;
      } else if (userType == 'center_admin') {
        final approvalStatus = HiveStorageService.getWellnessApprovalStatus();
        if (approvalStatus == 'approved') {
          if (context.mounted) {
            context.go(RouteConstant.wellnessDashboard);
          }
        } else {
          if (context.mounted) {
            context.go(RouteConstant.onBoarding);
          }
        }
        return;
      }
    }

    if (context.mounted) {
      context.go(RouteConstant.onBoarding);
    }
  }
}
