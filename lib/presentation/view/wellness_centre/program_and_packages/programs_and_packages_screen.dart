import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../controller/wellnesscentrecontroller/program_and_packages_controller.dart';
import 'widget/program_create_button.dart';
import 'widget/admin_control_banner.dart';
import 'widget/program_summary_cards.dart';
import 'widget/program_search_bar.dart';
import 'widget/program_list.dart';
import 'widget/programs_and_packages_shimmer.dart';

class ProgramsAndPackagesScreen extends StatelessWidget {
  const ProgramsAndPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<ProgramAndPackagesController>(
          init: ProgramAndPackagesController(),
          builder: (controller) {
            return Column(
              children: [
                const CommonAppBar(
                  title: 'Programs & Packages',
                  showBackButton: false,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: const Text(
                            "Programs & Packages",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Create and manage premium wellness journeys and signature treatment offers.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorConstant.greyColor,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ProgramCreateButton(
                          onTap: () => controller.createNewProgram(context),
                        ),
                        const SizedBox(height: 24),
                        const AdminControlBanner(),
                        const SizedBox(height: 24),
                        ProgramSummaryCards(
                          metrics: controller.summaryMetrics,
                        ),
                        const SizedBox(height: 24),
                        ProgramSearchBar(
                          searchController: controller.searchController,
                          selectedState: controller.selectedStatus,
                          status: controller.availabilityStatus,
                          onStateChanged: controller.onStateChanged,
                        ),
                        const SizedBox(height: 24),
                        controller.isLoading
                            ? const ProgramsAndPackagesShimmer()
                            : ProgramList(
                                programs: controller.filteredPrograms,
                                controller: controller,
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
