import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/wellnesscentrecontroller/revenue_controller.dart';
import 'package:healing/common/common_methods.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../core/color_constant/color_constant.dart';
import 'widget/revenue_chart.dart';
import '../../../../../../../common/app_shimmer.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<RevenueController>(
          init: RevenueController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Revenue',
                  showBackButton: true,
                ),

                Expanded(
                  child: controller.isLoading
                      ? const RevenueScreenShimmer()
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Total Revenue Banner card
                              _buildTotalRevenueCard(
                                controller.totalRevenue,
                                controller.growthPercentage,
                                controller.activeBookings + controller.completedBookings,
                              ),
                              const SizedBox(height: 16),

                              // Stats Grid (Confirmed and Completed)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildBookingStatCard(
                                      label: 'CONFIRMED / IN PROGRESS',
                                      value: '${controller.activeBookings}',
                                      subtitle: 'Active bookings',
                                      statusTag: 'Active',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildBookingStatCard(
                                      label: 'COMPLETED',
                                      value: '${controller.completedBookings}',
                                      subtitle: 'Completed bookings',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Revenue by month card (includes line graph)
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Revenue by month',
                                              style: TextStyle(
                                                fontFamily: 'Afacad',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: ColorConstant.lightBlackColor,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              'Based on booking creation date',
                                              style: TextStyle(
                                                fontFamily: 'Afacad',
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.more_horiz_rounded, color: Colors.grey),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Graph Painter
                                    RevenueChart(
                                      xLabels: controller.chartLabels,
                                      values: controller.chartValues,
                                    ),
                                    const SizedBox(height: 24),

                                    // List below graph
                                    if (controller.monthlyRevenue.isEmpty)
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: Text(
                                            'No monthly revenue data available',
                                            style: TextStyle(
                                              fontFamily: 'Afacad',
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.monthlyRevenue.length,
                                        itemBuilder: (ctx, index) {
                                          final item = controller.monthlyRevenue[index];
                                          final String month = item['month'] ?? '';
                                          final double val = item['value'] ?? 0.0;
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: index == controller.monthlyRevenue.length - 1 ? 0 : 12.0,
                                            ),
                                            child: _buildMonthListItem(
                                              month: month,
                                              amount: formatIndianPrice(val),
                                              color: val > 0 ? ColorConstant.appColor : Colors.grey.shade400,
                                            ),
                                          );
                                        },
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

  Widget _buildTotalRevenueCard(double revenue, double growth, int paidCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL REVENUE',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up, size: 14, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 4),
                    Text(
                      '${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: growth >= 0 ? const Color(0xFF2E7D32) : Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹${revenue.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ColorConstant.appColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'From $paidCount paid bookings',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingStatCard({
    required String label,
    required String value,
    required String subtitle,
    String? statusTag,
  }) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (statusTag != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusTag,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0369A1),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthListItem({
    required String month,
    required String amount,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.grey,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          month,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const Spacer(),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class RevenueScreenShimmer extends StatelessWidget {
  const RevenueScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Revenue Card Shimmer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppShimmer(width: 100, height: 11),
                    const AppShimmer(width: 60, height: 20, radius: 10),
                  ],
                ),
                const SizedBox(height: 12),
                const AppShimmer(width: 180, height: 32, radius: 4),
                const SizedBox(height: 10),
                const AppShimmer(width: 120, height: 12, radius: 4),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Stats Grid Shimmer
          Row(
            children: [
              Expanded(
                child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppShimmer(width: 60, height: 10),
                          const AppShimmer(width: 40, height: 16, radius: 8),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const AppShimmer(width: 40, height: 28),
                      const SizedBox(height: 8),
                      const AppShimmer(width: 80, height: 11),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppShimmer(width: 60, height: 10),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const AppShimmer(width: 40, height: 28),
                      const SizedBox(height: 8),
                      const AppShimmer(width: 80, height: 11),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Revenue by Month Card Shimmer
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppShimmer(width: 120, height: 16),
                        const SizedBox(height: 6),
                        const AppShimmer(width: 160, height: 12),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const AppShimmer(width: double.infinity, height: 220, radius: 12),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const AppShimmer(width: 36, height: 36, radius: 18),
                    const SizedBox(width: 12),
                    const AppShimmer(width: 80, height: 14),
                    const Spacer(),
                    const AppShimmer(width: 60, height: 14),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const AppShimmer(width: 36, height: 36, radius: 18),
                    const SizedBox(width: 12),
                    const AppShimmer(width: 80, height: 14),
                    const Spacer(),
                    const AppShimmer(width: 60, height: 14),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
