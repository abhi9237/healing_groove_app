import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/controller/wellnesscentrecontroller/program_preview_detail_controller.dart';
import '../../../../common/common_app_bar.dart';
import '../../../../common/common_auth_background.dart';
import 'widget/program_preview_header.dart';
import 'widget/program_preview_details_grid.dart';
import 'widget/program_preview_pricing.dart';
import 'widget/program_preview_calendar.dart';
import 'widget/program_preview_summary.dart';

class ProgramPreviewDetailScreen extends StatelessWidget {
  final DocModel program;
  const ProgramPreviewDetailScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<ProgramPreviewDetailController>(
          init: ProgramPreviewDetailController(program: program),
          builder: (controller) {
            return Column(
              children: [
                // Top App Bar
                const CommonAppBar(
                  title: 'Programs & Packages',
                  showBackButton: true,
                ),
                // Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header info
                        ProgramPreviewHeader(program: controller.program),
                        const SizedBox(height: 24),

                        // Details Grid
                        ProgramPreviewDetailsGrid(program: controller.program),
                        const SizedBox(height: 24),

                        // Pricing and Inclusions
                        ProgramPreviewPricing(program: controller.program),
                        const SizedBox(height: 24),

                        // Availability Calendar
                        ProgramPreviewCalendar(
                          program: controller.program,
                          availableDates: controller.availableDateTimes,
                        ),
                        const SizedBox(height: 24),

                        // Summary Totals
                        ProgramPreviewSummary(controller: controller),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // Bottom "Edit Program" Action Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FBF9),
          border: Border(
            top: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
          ),
        ),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              context.push(RouteConstant.addNewProgram, extra: program);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF08864F),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Edit Program',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
