import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/usercontroller/edit_profile_controller.dart';
import 'package:healing/presentation/view/user/edit_profile/widget/edit_profile_shimmer_effect.dart';
import 'widget/edit_profile_header_card.dart';
import 'widget/edit_personal_space_card.dart';
import 'widget/edit_security_card.dart';
import 'widget/edit_wellness_goals_card.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppBackground(
        child: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonAppBar(title: 'My Profile'),
                controller.isLoading.value == true
                    ? ProfileShimmerLoading()
                    : Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditProfileHeaderCard(controller: controller),

                              EditPersonalSpaceCard(controller: controller),
                              const SizedBox(height: 12),

                              EditSecurityCard(controller: controller),
                              const SizedBox(height: 12),

                              EditWellnessGoalsCard(controller: controller),
                            ],
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
