import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/common_auth_background.dart';
import '../../../../common/setup_progress_bar.dart';
import '../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import 'widget/description_input.dart';
import 'widget/core_speciality_input.dart';
import 'widget/capacity_rooms_input.dart';
import 'widget/services_offered_input.dart';
import 'widget/facilities_amenities_input.dart';
import 'widget/info_card.dart';
import 'widget/action_buttons.dart';

class CentreDetail extends StatelessWidget {
  const CentreDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final SetupCenterDetailController controller = Get.isRegistered<SetupCenterDetailController>()
        ? Get.find<SetupCenterDetailController>()
        : Get.put(SetupCenterDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CommonAppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
                currentStep: 2,
                totalSteps: 3,
                progress: 0.66,
              ),
              const SizedBox(height: 24),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // Headers
                      const Text(
                        'Center Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF08864F), // Using app primary color
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tell us more about what you offer',
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
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: controller.formKeyStep2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DescriptionInput(controller: controller.descriptionController),
                              const SizedBox(height: 16),
                              CoreSpecialityInput(controller: controller.coreSpecialityController),
                              const SizedBox(height: 16),
                              CapacityRoomsInput(
                                capacityController: controller.capacityController,
                                roomsController: controller.roomsController,
                              ),
                              const SizedBox(height: 16),
                              ServicesOfferedInput(controller: controller.servicesController),
                              const SizedBox(height: 16),
                              FacilitiesAmenitiesInput(controller: controller.facilitiesController),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Info Card
                      const InfoCard(),
                      const SizedBox(height: 32),

                      // Bottom Action Buttons
                      ActionButtons(
                        onContinue: () => controller.onStep2Continue(context),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
