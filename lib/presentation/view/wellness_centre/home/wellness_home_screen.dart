import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../controller/wellnesscentrecontroller/wellness_home_controller.dart';
import 'widget/checkins_card.dart';
import 'widget/revenue_card.dart';
import 'widget/pending_requests_card.dart';
import 'widget/booking_status_card.dart';
import 'widget/overview_card.dart';
import 'widget/recent_bookings_section.dart';
import '../../../../../common/app_shimmer.dart';

class WellnessHomeScreen extends StatelessWidget {
  const WellnessHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<WellnessHomeController>(
          init: WellnessHomeController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: controller.refreshHomeData,
              color: const Color(0xFF08864F),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                     CommonAppBar(
                      titleColor: ColorConstant.greyColor,
                      title: 'Welcome back, ${HiveStorageService.getUserName()}',
                      showBackButton: false,
                    ),
                    Expanded(
                      child: controller.isLoading
                          ? const WellnessHomeScreenShimmer()
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 24),
                                  CheckinsCard(count: controller.todayCheckinsCount),
                                  const SizedBox(height: 16),
                                  RevenueCard(revenue: controller.totalRevenueK),
                                  const SizedBox(height: 16),
                                  PendingRequestsCard(count: controller.pendingRequestsCount),
                                  const SizedBox(height: 24),
                                  BookingStatusCard(statusData: controller.bookingStatusData),
                                  const SizedBox(height: 24),
                                  OverviewCard(overviewData: controller.overviewData),
                                  const SizedBox(height: 24),
                                  RecentBookingsSection(recentBookings: controller.recentBookings),
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

class WellnessHomeScreenShimmer extends StatelessWidget {
  const WellnessHomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const AppShimmer(width: double.infinity, height: 110, radius: 20),
          const SizedBox(height: 16),
          const AppShimmer(width: double.infinity, height: 110, radius: 20),
          const SizedBox(height: 16),
          const AppShimmer(width: double.infinity, height: 110, radius: 20),
          const SizedBox(height: 24),
          const AppShimmer(width: double.infinity, height: 180, radius: 20),
          const SizedBox(height: 24),
          const AppShimmer(width: double.infinity, height: 180, radius: 20),
        ],
      ),
    );
  }
}
