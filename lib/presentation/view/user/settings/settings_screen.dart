import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/settings_controller.dart';
import 'widget/settings_profile_card.dart';
import 'widget/settings_account_options.dart';
import 'widget/settings_notifications_card.dart';
import 'widget/settings_privacy_card.dart';
import 'widget/settings_logout_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return CommonAppBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const CommonAppBar(
                    title: 'Settings',
                    showBackButton: false,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SettingsProfileCard(),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Manage your account preferences and notifications to optimize your healing journey.',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: ColorConstant.greyColor,
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const SettingsAccountOptions(),
                        // const SizedBox(height: 12),
                        // const SettingsNotificationsCard(),
                        const SizedBox(height: 12),

                        const SettingsPrivacyCard(),
                        const SizedBox(height: 8),

                        SettingsLogoutButton(controller: controller),

                        // Space at bottom of list
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
