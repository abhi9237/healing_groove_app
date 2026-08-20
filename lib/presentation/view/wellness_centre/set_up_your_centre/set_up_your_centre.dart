import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/common_auth_background.dart';
import '../../../../common/setup_progress_bar.dart';
import '../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import 'widget/center_name_input.dart';
import 'widget/country_dropdown.dart';
import 'widget/city_input.dart';
import 'widget/phone_number_input.dart';
import 'widget/email_input.dart';
import 'widget/continue_button.dart';

class SetUpYourCentre extends StatelessWidget {
  const SetUpYourCentre({super.key});

  @override
  Widget build(BuildContext context) {
    final SetupCenterDetailController controller = Get.put(
      SetupCenterDetailController(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CommonAppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                currentStep: 1,
                totalSteps: 3,
                progress: 0.33,
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Headers
                      const Text(
                        'Set up your center',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF08864F), // Using app primary color
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Basic details for your wellness business',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
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
                        child: Form(
                          key: controller.formKeyStep1,
                          child: Column(
                            children: [
                              CenterNameInput(
                                controller: controller.centerNameController,
                              ),
                              const SizedBox(height: 16),
                              CountryDropdown(controller: controller),
                              const SizedBox(height: 16),
                              CityInput(controller: controller.cityController),
                              const SizedBox(height: 16),
                              PhoneNumberInput(controller: controller),
                              const SizedBox(height: 16),
                              EmailInput(
                                controller: controller.emailController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Action Button
                      ContinueButton(
                        onTap: () => controller.onStep1Continue(context),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
