import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/guest_controller.dart';
import '../../../../../../../common/common_app_bar.dart';
import '../../../../../../../common/common_auth_background.dart';
import '../../../../../../../common/common_widget.dart';
import '../../../../../../../common/common_text_form_filled.dart';
import '../../../../../../../core/route/route_constant/route_constant.dart';
import 'widget/guest_stats_card.dart';
import 'widget/guest_card.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<GuestController>(
          init: GuestController(),
          builder: (controller) {
            return Column(
              children: [
                // App Bar
                const CommonAppBar(
                  title: 'Guest',
                  showBackButton: true,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Grid (2 columns)
                        Row(
                          children: [
                            Expanded(
                              child: GuestStatsCard(
                                icon: Icons.person_outline_rounded,
                                iconColor: const Color(0xFF007A48),
                                iconBgColor: const Color(0xFFE8F5E9),
                                label: 'TOTAL GUESTS',
                                value: '${controller.totalGuestsCount}',
                                subtitle: 'Unique bookers',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GuestStatsCard(
                                icon: Icons.calendar_month_outlined,
                                iconColor: const Color(0xFF0D9488),
                                iconBgColor: const Color(0xFFF0FDFA),
                                label: 'ACTIVE',
                                value: '${controller.activeGuestsCount}',
                                subtitle: 'Confirmed or in-progress',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: GuestStatsCard(
                                icon: Icons.person_add_alt_1_outlined,
                                iconColor: const Color(0xFF4F46E5),
                                iconBgColor: const Color(0xFFEEF2FF),
                                label: 'RETURNING',
                                value: '${controller.returningGuestsCount}',
                                subtitle: 'More than 1 booking',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GuestStatsCard(
                                icon: Icons.account_balance_wallet_outlined,
                                iconColor: const Color(0xFF0284C7),
                                iconBgColor: const Color(0xFFF0F9FF),
                                label: 'REVENUE',
                                value: '₹16.6K',
                                subtitle: 'From paid bookings',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Search & Filter Box Card
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
                                hintText: 'Search by name, email, or phone...',
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
                                      'Requested',
                                      'Confirmed',
                                      'In Progress',
                                      'Completed',
                                      'Cancelled',
                                      'Returning',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Green showing count indicator
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF007A48),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Showing ${controller.filteredGuests.length} of ${controller.totalGuestsCount} guests',
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Guests List
                        if (controller.isLoading)
                          const Center(
                            child: CommonCircularIndicator(),
                          )
                        else if (controller.filteredGuests.isEmpty)
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
                                    'No guests found',
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
                            itemCount: controller.filteredGuests.length,
                            itemBuilder: (ctx, index) {
                              final guest = controller.filteredGuests[index];
                              final String name = guest.user?.name ??
                                  (guest.guests != null && guest.guests!.isNotEmpty
                                      ? guest.guests![0].fullName ?? ''
                                      : '');
                              return GuestCard(
                                booking: guest,
                                bookingsCount: controller.guestBookingsCount[name] ?? 1,
                                totalSpend: controller.guestTotalSpend[name] ?? 0.0,
                                lastBookingDate: controller.guestLastBookingDate[name] ?? '—',
                                isReturning: controller.guestIsReturning[name] ?? false,
                                onViewDetails: () {
                                  if (guest.bookingNumber != null) {
                                    GoRouter.of(context).pushNamed(
                                      RouteConstant.wellnessBookingDetail,
                                      pathParameters: {'id': guest.bookingNumber!},
                                      extra: guest,
                                    );
                                  }
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
