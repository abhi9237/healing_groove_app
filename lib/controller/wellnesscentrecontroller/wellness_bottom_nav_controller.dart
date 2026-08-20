import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_and_packages_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import '../../presentation/view/wellness_centre/home/wellness_home_screen.dart';
import '../../presentation/view/wellness_centre/bookings/wellness_bookings_screen.dart';
import '../../presentation/view/wellness_centre/program_and_packages/programs_and_packages_screen.dart';
import '../../presentation/view/wellness_centre/wellness_bottom_navigation/tabs/wellness_settings_tab.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_booking_controller.dart';
import '../../repository/set_up_center_detail_repository.dart';

class WellnessBottomNavController extends GetxController {
  int currentIndex = 0;


  final List<Widget> tabs = const [
    WellnessHomeScreen(),
    WellnessBookingsScreen(),
    ProgramsAndPackagesScreen(),
    WellnessSettingsTab(),
  ];

  final List<Map<String, dynamic>> items = [
    {
      'icon': Icons.home_outlined,
      'selectedIcon': Icons.home_rounded,
      'label': 'Home',
    },
    {
      'icon': Icons.calendar_today_outlined,
      'selectedIcon': Icons.calendar_today_rounded,
      'label': 'Bookings',
    },
    {
      'icon': Icons.inventory_2_outlined,
      'selectedIcon': Icons.inventory_2_rounded,
      'label': 'Programs',
    },
    {
      'icon': Icons.settings_outlined,
      'selectedIcon': Icons.settings_rounded,
      'label': 'Settings',
    },
  ];

  void changeIndex(int index) {
    if (index >= 0 && index < tabs.length) {
      currentIndex = index;
      update();

      if (index == 1) {
        try {
          if (Get.isRegistered<WellnessBookingController>()) {
            Get.find<WellnessBookingController>().fetchBookingsFromApi(isRefresh: true);
          }
        } catch (e) {
          log('Error triggering refresh in bottom nav changeIndex: $e');
        }
      }
      if (index == 2) {
        try {
          if (Get.isRegistered<ProgramAndPackagesController>()) {
            Get.find<ProgramAndPackagesController>().fetchPrograms();
          }
        } catch (e) {
          log('Error triggering refresh in bottom nav changeIndex: $e');
        }
      }
    }
  }

  void onFabPressed(BuildContext context) {
    context.push(RouteConstant.addNewProgram);
  }
}
