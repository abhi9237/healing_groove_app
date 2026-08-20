import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/app_loader.dart';
import '../../../../common/common_auth_background.dart';
import '../../../../common/setup_progress_bar.dart';
import '../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import 'widget/featured_image_picker.dart';
import 'widget/action_buttons.dart';

class MakeItShine extends StatelessWidget {
  const MakeItShine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: SetupCenterDetailController(),
        builder: (SetupCenterDetailController controller) {
          return AppLoader(
            isLoading: controller.isLoading,
            child: CommonAppBackground(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back Icon at the top
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: ColorConstant.lightBlackColor,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Progress Bar
                    const SetupProgressBar(
                      currentStep: 3,
                      totalSteps: 3,
                      progress: 1.0,
                    ),
                    const SizedBox(height: 24),

                    // Headers
                    const Text(
                      'Make it shine',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF08864F), // Using app primary color
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload a featured image for your center',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                    ),
                    const SizedBox(height: 24),

                    // Form Container Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [FeaturedImagePicker(controller: controller)],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Bottom Action Buttons
                    ActionButtons(
                      onSubmit: () => controller.uploadImages(context),
                      isLoading: false,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
