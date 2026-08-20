import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../controller/wellnesscentrecontroller/add_new_program_controller.dart';
import 'widget/visibility_banner.dart';
import 'widget/basic_info_fields.dart';
import 'widget/available_dates_picker.dart';
import 'widget/services_checklist.dart';
import 'widget/price_summary.dart';
import 'widget/add_program_actions.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class AddNewProgramScreen extends StatelessWidget {
  final DocModel? program;
  const AddNewProgramScreen({super.key, this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<AddNewProgramController>(
          init: AddNewProgramController(program: program),
          builder: (controller) {
            int checkedCount = 0;
            for (var svc in controller.services) {
              if (svc.isActive as bool) {
                checkedCount++;
              }
            }

            return Column(
              children: [
                CommonAppBar(
                  title: program != null ? 'Update Program' : 'Add New Program',
                  showBackButton: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const VisibilityBanner(),
                        const SizedBox(height: 24),
                        BasicInfoFields(
                          nameController: controller.nameController,
                          descriptionController:
                              controller.descriptionController,
                          durationController: controller.durationController,
                          priceController: controller.priceController,
                          minGuestsController: controller.minGuestsController,
                          maxGuestsController: controller.maxGuestsController,
                          selectedStatus: controller.selectedStatus,
                          statusOptions: controller.statusOptions,
                          onStatusChanged: controller.onStatusChanged,
                          imageFile: controller.programImage.value,
                          imageUrl: program?.image?.url,
                          onPickImage: () => controller.pickImage(context),
                        ),
                        const SizedBox(height: 24),
                        AvailableDatesPicker(controller: controller),
                        const SizedBox(height: 24),
                        ServicesChecklist(
                          services: controller.services,
                          onToggleService: controller.toggleService,
                          onAddServiceTap: () =>
                              controller.addCustomService(context),
                          isLoading: controller.isServicesLoading,
                        ),
                        const SizedBox(height: 24),
                        PriceSummary(
                          programPrice: controller.programPrice,
                          selectedServicesCount: checkedCount,
                          selectedServicesPrice:
                              controller.selectedServicesPrice,
                          totalEstimate: controller.totalEstimate,
                        ),
                        const SizedBox(height: 28),
                        AddProgramActions(
                          submitButtonText: program != null
                              ? 'Update Program'
                              : 'Add Program',
                          onCancel: () => Navigator.of(context).pop(),
                          onSubmit: () => controller.submitProgram(context),
                          isLoading: controller.isLoading,
                        ),
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
