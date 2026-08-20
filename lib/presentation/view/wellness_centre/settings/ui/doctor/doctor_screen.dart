import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/doctor_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../common/common_text_form_filled.dart';
import '../../../../../../../core/color_constant/color_constant.dart';
import 'widget/doctor_stats_grid.dart';
import 'widget/doctor_card.dart';
import '../../../../../../../common/app_shimmer.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<DoctorController>(
          init: DoctorController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Doctors',
                  showBackButton: true,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Grid (2 rows)
                        DoctorStatsGrid(
                          totalCount: controller.totalDoctorsCount,
                          approvedCount: controller.approvedDoctorsCount,
                          pendingCount: controller.pendingDoctorsCount,
                          avgExperience: controller.avgExperienceText,
                        ),
                        const SizedBox(height: 16),

                        // Add Doctor Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () => context.push(RouteConstant.addDoctor),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.appColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: const Text(
                              'Add Doctor',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Search & Filter Panel
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Search Input
                              CommonSearchTextFilled(
                                hintText: 'Search by name, specialization, or ID...',
                                controller: controller.searchController,
                                onChanged: controller.onSearchChanged,
                              ),
                              const SizedBox(height: 12),

                              // Status Dropdown
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: controller.selectedStatus,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.grey,
                                    ),
                                    isExpanded: true,
                                    style: const TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                    onChanged: controller.onStatusChanged,
                                    items: <String>[
                                      'All Status',
                                      'Approved',
                                      'Pending',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Doctors list view
                        if (controller.isLoading)
                          const DoctorListShimmer()
                        else if (controller.filteredDoctors.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.group_off_outlined,
                                    size: 48,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'No doctors found',
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredDoctors.length,
                            itemBuilder: (ctx, index) {
                              final doctor = controller.filteredDoctors[index];
                              return DoctorCard(
                                doctor: doctor,
                                onView: () {
                                  // Detail action
                                },
                                onEdit: () {
                                  // Edit action
                                },
                                onDelete: () {
                                  controller.deleteDoctor(doctor['id'] as int);
                                },
                              );
                            },
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

class DoctorListShimmer extends StatelessWidget {
  const DoctorListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (ctx, index) => const DoctorCardShimmer(),
    );
  }
}

class DoctorCardShimmer extends StatelessWidget {
  const DoctorCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppShimmer(width: 40, height: 40, radius: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppShimmer(width: 120, height: 16, radius: 4),
                    const SizedBox(height: 6),
                    const AppShimmer(width: 60, height: 12, radius: 4),
                  ],
                ),
              ),
              const AppShimmer(width: 70, height: 22, radius: 11),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: Colors.grey.shade300, size: 16),
              const SizedBox(width: 10),
              const AppShimmer(width: 150, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.school_outlined, color: Colors.grey.shade300, size: 16),
              const SizedBox(width: 10),
              const AppShimmer(width: 180, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.work_outline_rounded, color: Colors.grey.shade300, size: 16),
              const SizedBox(width: 10),
              const AppShimmer(width: 130, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Consultation: ',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const AppShimmer(width: 50, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: const AppShimmer(width: double.infinity, height: 40, radius: 10),
              ),
              const SizedBox(width: 8),
              const AppShimmer(width: 40, height: 40, radius: 10),
              const SizedBox(width: 8),
              const AppShimmer(width: 40, height: 40, radius: 10),
            ],
          ),
        ],
      ),
    );
  }
}
