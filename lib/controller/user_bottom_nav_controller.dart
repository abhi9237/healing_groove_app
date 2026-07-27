import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/edit_profile_controller.dart';
import 'package:healing/controller/enquiries_and_bookings_controller.dart';
import 'package:healing/controller/user_home_controller.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../presentation/view/user/enquiries_and_bookings/enquiries_and_bookings.dart';
import '../presentation/view/user/my_journey/my_journey.dart';
import '../presentation/view/user/settings/settings_screen.dart';
import '../presentation/view/user/user_home/user_home_screen.dart';

import 'my_journey_controller.dart';

class UserBottomNavController extends GetxController {
  int currentIndex = 0;

  final List<Widget> tabs = const [
    UserHomeScreen(),
    MyJourneyUi(),
    EnquiriesAndBookings(),
    SettingsScreen(),
  ];

  final List<Map<String, dynamic>> items = [
    {
      'selectedIcon': ImageConstant.homeSelectedIcon,
      'unselectedIcon': ImageConstant.homeUnSelectedIcon,
      'label': 'Home',
    },
    {
      'selectedIcon': ImageConstant.myJourneySelectedIcon,
      'unselectedIcon': ImageConstant.myJourneyUnSelectedIcon,
      'label': 'My Journey',
    },
    {
      'selectedIcon': ImageConstant.enquiriesSelectedIcon,
      'unselectedIcon': ImageConstant.enquiriesUnSelectedIcon,
      'label': 'Enquiries',
    },
    {
      'selectedIcon': ImageConstant.settingSelectedIcon,
      'unselectedIcon': ImageConstant.settingUnSelectedIcon,
      'label': 'Settings',
    },
  ];

  void changeIndex(int index) {
    if (index == 0) {
      if (Get.isRegistered<UserHomeController>()) {
        Get.find<UserHomeController>().getUserProfile();
      }
    }

    if (index == 1 && currentIndex != 1) {
      if (Get.isRegistered<MyJourneyController>()) {
        Get.find<MyJourneyController>().refreshBookings();
      }
    }

    if (index == 2) {
      if (Get.isRegistered<EnquiriesAndBookingsController>()) {
        Get.find<EnquiriesAndBookingsController>().fetchEnquiriesAndBookings(
          isRefresh: true,
        );
      }
    }
    currentIndex = index;
    update();
  }
}
