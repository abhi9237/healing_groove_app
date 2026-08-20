import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route/route_constant/route_constant.dart';
import '../../../../controller/wellnesscentrecontroller/wellness_bottom_nav_controller.dart';
import 'widget/wellness_bottom_bar.dart';
import '../../../../common/wellness_drawer.dart';

class WellnessBottomNavView extends StatelessWidget {
  final Widget child;
  const WellnessBottomNavView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WellnessBottomNavController>(
      init: WellnessBottomNavController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          drawer: const WellnessDrawer(),
          bottomNavigationBar: SafeArea(
            child: WellnessBottomBar(
              onTap: (index) {
                controller.changeIndex(index);
                context.go(RouteConstant.wellnessDashboard);
              },
              controller: controller,
            ),
          ),
          body: child,
        );
      },
    );
  }
}

class WellnessDashboardTabsScreen extends StatelessWidget {
  const WellnessDashboardTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WellnessBottomNavController>(
      builder: (controller) {
        return IndexedStack(
          index: controller.currentIndex,
          children: controller.tabs,
        );
      },
    );
  }
}
