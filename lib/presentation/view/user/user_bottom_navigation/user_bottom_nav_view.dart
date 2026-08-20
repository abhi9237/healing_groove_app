import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/controller/usercontroller/user_bottom_nav_controller.dart';
import 'widget/user_bottom_bar.dart';

class UserBottomNavView extends StatelessWidget {
  final Widget child;
  const UserBottomNavView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBottomNavController>(
      init: UserBottomNavController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: UserBottomBar(
            onTap: (index) {
              controller.changeIndex(index);
              context.go(RouteConstant.userDashboard);
            },
            controller: controller,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          body: child,
        );
      },
    );
  }
}

class UserDashboardTabsScreen extends StatelessWidget {
  const UserDashboardTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBottomNavController>(
      builder: (controller) {
        return IndexedStack(
          index: controller.currentIndex,
          children: controller.tabs,
        );
      },
    );
  }
}
