import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import '../../../../controller/wellnesscentrecontroller/services_controller.dart';
import 'widget/service_header.dart';
import 'widget/service_form_fields.dart';
import 'widget/service_active_toggle.dart';
import 'widget/service_action_buttons.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: false,
        child: GetBuilder<ServicesController>(
          init: ServicesController(),
          builder: (controller) {
            return AppLoader(
              isLoading: controller.isLoadingService,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    CommonAppBar(
                      title: controller.editingServiceId != null
                          ? 'Edit Service'
                          : 'Add Services',
                      showBackButton: true,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ServiceHeader(controller: controller),
                            const SizedBox(height: 24),
                            ServiceFormFields(
                              nameController: controller.nameController,
                              descriptionController:
                                  controller.descriptionController,
                              priceController: controller.priceController,
                            ),
                            const SizedBox(height: 24),
                            ServiceActiveToggle(
                              isActive: controller.isActive,
                              onToggle: controller.toggleActive,
                            ),
                            const SizedBox(height: 28),
                            ServiceActionButtons(
                              controller: controller,
                              onCancel: () => Navigator.of(context).pop(),
                              onCreate: () => controller.submitService(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
