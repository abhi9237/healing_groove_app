import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/common_auth_background.dart';
import '../../../../../controller/wellnesscentrecontroller/wellness_booking_controller.dart';
import 'widget/booking_summary_cards.dart';
import 'widget/booking_search_bar.dart';
import 'widget/booking_list.dart';
import 'widget/booking_shimmer_list.dart';

class WellnessBookingsScreen extends StatelessWidget {
  const WellnessBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: true,
        child: GetBuilder<WellnessBookingController>(
          init: WellnessBookingController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: controller.refreshBookings,
              color: const Color(0xFF08864F),
              child: Column(
                children: [
                  const CommonAppBar(
                    title: 'Booking Management',
                    showBackButton: false,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100, top: 8, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Manage guest bookings through their complete lifecycle.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF414943),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BookingSummaryCards(metrics: controller.summaryMetrics),
                          const SizedBox(height: 24),
                          BookingSearchBar(
                            searchController: controller.searchController,
                            onFilterTap: () => _showStatusFilterBottomSheet(
                              context: context,
                              controller: controller,
                            ),
                          ),
                          const SizedBox(height: 24),
                          controller.isLoading
                              ? const BookingShimmerList()
                              : BookingList(
                                  bookings: controller.filteredDocs,
                                  controller: controller,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showStatusFilterBottomSheet({
    required BuildContext context,
    required WellnessBookingController controller,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
                child: Text(
                  'Filter Bookings by Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ),
              ...['All', 'Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled'].map((status) {
                final isSelected = controller.selectedStatus == status;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorConstant.appColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? ColorConstant.appColor
                          : Colors.grey.shade200,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 2,
                    ),
                    title: Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? ColorConstant.appColor
                            : ColorConstant.lightBlackColor,
                      ),
                    ),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isSelected ? ColorConstant.appColor : Colors.grey,
                    ),
                    onTap: () {
                      controller.updateSelectedStatus(status);
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
