import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/wellnesscentrecontroller/report_controller.dart';
import 'package:healing/common/common_methods.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../core/color_constant/color_constant.dart';
import 'widget/report_info_row.dart';
import '../../../../../../../common/app_shimmer.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<ReportController>(
          init: ReportController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Report',
                  showBackButton: true,
                ),

                Expanded(
                  child: controller.isLoading
                      ? const ReportScreenShimmer()
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              // Card 1: Bookings by status
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
                                    const Text(
                                      'Bookings by status',
                                      style: TextStyle(
                                        fontFamily: 'Afacad',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstant.lightBlackColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ReportInfoRow(
                                      label: 'Initiated',
                                      value: '${controller.initiatedBookings}',
                                    ),
                                    ReportInfoRow(
                                      label: 'Confirmed',
                                      value: '${controller.confirmedBookings}',
                                    ),
                                    ReportInfoRow(
                                      label: 'Awaiting confirmation',
                                      value: '${controller.awaitingConfirmation}',
                                      showDivider: false,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Card 2: Summary
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
                                    const Text(
                                      'Summary',
                                      style: TextStyle(
                                        fontFamily: 'Afacad',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstant.lightBlackColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ReportInfoRow(
                                      label: 'Total bookings',
                                      value: '${controller.totalBookings}',
                                    ),
                                    ReportInfoRow(
                                      label: 'Total revenue (paid)',
                                      value: formatIndianPrice(controller.totalRevenuePaid),
                                    ),
                                    ReportInfoRow(
                                      label: 'Avg. booking value (paid)',
                                      value: formatIndianPrice(controller.avgBookingValue),
                                      showDivider: false,
                                    ),
                                  ],
                                ),
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

class ReportScreenShimmer extends StatelessWidget {
  const ReportScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Card 1 Shimmer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmer(width: 140, height: 16),
                SizedBox(height: 24),
                AppShimmer(width: double.infinity, height: 16),
                SizedBox(height: 16),
                AppShimmer(width: double.infinity, height: 16),
                SizedBox(height: 16),
                AppShimmer(width: double.infinity, height: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Card 2 Shimmer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmer(width: 100, height: 16),
                SizedBox(height: 24),
                AppShimmer(width: double.infinity, height: 16),
                SizedBox(height: 16),
                AppShimmer(width: double.infinity, height: 16),
                SizedBox(height: 16),
                AppShimmer(width: double.infinity, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
