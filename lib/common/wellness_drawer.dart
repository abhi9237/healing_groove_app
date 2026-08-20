import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_settings_controller.dart';

import 'package:healing/common/app_loader.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

import '../core/image_constant/image_constant.dart';

class WellnessDrawer extends StatelessWidget {
  const WellnessDrawer({super.key});

  Future<void> logOut(BuildContext context) async {
    final controller = Get.put(WellnessSettingsController());
    await controller.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = '';
    try {
      currentRoute = GoRouterState.of(context).matchedLocation;
    } catch (_) {}

    final controller = Get.put(WellnessSettingsController());

    return AppLoader(
      isLoading: controller.isLoggingOut,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          children: [
            // Drawer Header Area
            Container(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4FD), // Light purple-blue card
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Admin avatar
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.appColor,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        ImageConstant.userImg,
                        fit: BoxFit.contain,
                        color: ColorConstant.appColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HiveStorageService.getUserName() ?? '',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.lightBlackColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Manager Portal',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Drawer Body Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // _buildDrawerItem(
                  //   icon: Icons.chat_bubble_outline_rounded,
                  //   title: 'Consultation requests',
                  //   isSelected:
                  //       currentRoute == RouteConstant.consultationRequest,
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     context.push(RouteConstant.consultationRequest);
                  //   },
                  // ),
                  _buildDrawerItem(
                    icon: Icons.people_outline_rounded,
                    title: 'Guests',
                    isSelected: currentRoute == RouteConstant.guest,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.guest);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.medical_services_outlined,
                    title: 'Doctors',
                    isSelected: currentRoute == RouteConstant.doctors,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.doctors);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Revenue',
                    isSelected: currentRoute == RouteConstant.revenue,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.revenue);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.bar_chart_rounded,
                    title: 'Reports',
                    isSelected: currentRoute == RouteConstant.report,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.report);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.gavel_rounded,
                    title: 'Terms and Condition',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.termsAndPrivacy, extra: {'isTerms': true});
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.termsAndPrivacy, extra: {'isTerms': false});
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Support',
                    isSelected: currentRoute == RouteConstant.support,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(RouteConstant.support);
                    },
                  ),
                ],
              ),
            ),

            // Drawer Footer Area (Logout Button & Version)
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              color: const Color(0xFFF8FAFC), // very light grey/blue
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () => logOut(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFFCA5A5),
                          width: 1.2,
                        ), // Light red border
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFDC2626), // red
                        size: 18,
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDC2626), // red
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Version Info
                  Text(
                    'v1.2.0 • © 2024 The Healing Groove',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 10.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstant.appColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey.shade700,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : ColorConstant.lightBlackColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
