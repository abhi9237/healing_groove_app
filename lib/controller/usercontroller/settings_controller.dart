import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/presentation/model/response/user_profile_response_model.dart';
import '../../repository/settings_repository.dart';

class SettingsController extends GetxController {
  bool bookingUpdates = true;
  bool journeyReminders = true;
  bool wellnessOffers = false;

  SettingsRepository repository = SettingsRepository();
  UserProfileResponseModel? userProfileModel;
  RxBool isLoading = false.obs;

  void toggleBookingUpdates(bool value) {
    bookingUpdates = value;
    update();
  }

  void toggleJourneyReminders(bool value) {
    journeyReminders = value;
    update();
  }

  void toggleWellnessOffers(bool value) {
    wellnessOffers = value;
    update();
  }

  Future<void> logOut(BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await repository.logout();
      if (response.statusCode == 200) {
        HiveStorageService.eraseAllData();
        HiveStorageService.storeRememberMe(false);
        if (context.mounted) {
          context.go(RouteConstant.authSelection);
        }
      }
    } catch (e) {
      log('Error ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
