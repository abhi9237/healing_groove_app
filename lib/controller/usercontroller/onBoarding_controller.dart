import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/controller/auth_controller.dart';

class OnboardingController extends GetxController {
  OnboardingController({this.context});
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  BuildContext? context;
  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      imagePath: ImageConstant.onBoardingOne,
      title: 'Your Path to Vitality',
      description:
          'Join a community of thousands on a personalized journey toward holistic health and vibrant living.',
      buttonText: 'Begin Your Journey',
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(160),
        topRight: Radius.circular(160),
        bottomLeft: Radius.circular(160),
        bottomRight: Radius.circular(40),
      ),
    ),
    OnboardingPageData(
      imagePath: ImageConstant.onBoardingTwo,
      title: 'Breathe in the Balance',
      description:
          'Master the art of conscious breathing to reduce stress and unlock natural energy within minutes.',
      buttonText: 'Start Breathing',
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(120),
        topRight: Radius.circular(160),
        bottomLeft: Radius.circular(160),
        bottomRight: Radius.circular(120),
      ),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> navigateToNextPage() async {
    // await refreshToken();
    // // if (getDateTimeFromTimestamp(
    // //   HiveStorageService.getTokenExpiry() ?? 0,
    // // ).isBefore(DateTime.now())) {
    // //   await refreshToken();
    // // }
    await Future.delayed(const Duration(seconds: 3));
    if (HiveStorageService.getUserToken() != null &&
        HiveStorageService.getRememberMe() == true &&
        HiveStorageService.getUserType() == 'user') {
      context!.go(RouteConstant.userDashboard);
    } else if (HiveStorageService.getUserToken() != null &&
        HiveStorageService.getRememberMe() == true &&
        HiveStorageService.getUserType() == 'center_admin' &&
        HiveStorageService.getWellnessApprovalStatus() == 'approved') {
      context!.go(RouteConstant.wellnessDashboard);
    }
  }

  DateTime getDateTimeFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  Future<void> refreshToken() async {
    try {
      final authController = Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
      await authController.refreshToken();
    } catch (e) {
      log('Error refreshing token: $e');
    } finally {}
    update();
  }

  void onTap(BuildContext context, int index) {
    currentPage.value = 1;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (index > 1) {
      context.go(RouteConstant.welcome);
    }
  }

  void onTapCreateAccount(BuildContext context) {
    context.go(RouteConstant.authSelection);
  }

  void onTapSignIn(BuildContext context) {
    context.go(RouteConstant.login);
  }
}

class OnboardingPageData {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final BorderRadius borderRadius;

  OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.borderRadius,
  });
}
