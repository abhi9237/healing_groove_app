import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_bottom_nav_controller.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../../common/common_methods.dart';
import '../../../../../core/color_constant/color_constant.dart';

class RecentBookingsSection extends StatelessWidget {
  final List<DocModel> recentBookings;
  const RecentBookingsSection({super.key, required this.recentBookings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Bookings",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Latest booking requests and confirmations",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 12.5,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                try {
                  if (Get.isRegistered<WellnessBottomNavController>()) {
                    Get.find<WellnessBottomNavController>().changeIndex(1);
                  }
                } catch (e) {
                  debugPrint('Error navigating to bookings tab: $e');
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                "View\nAll",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Bookings List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentBookings.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = recentBookings[index];
            final String name = item.center?.name ??  '';
            final String program = item.package?.name ?? 'Special Program';
            final String date = item.startDate ?? 'N/A';
            final String status = item.status ?? 'Pending';
            final String price = formatIndianPrice(
              (item.totalAmount ?? 0).toDouble(),
            );
            final String avatarUrl =
                'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png';

            final isConfirmed = status == 'Confirmed';

            return InkWell(
              onTap: () {
                context.push(RouteConstant.wellnessBookingDetail, extra: item);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Avatar Image
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Middle details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.lightBlackColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            program,
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 12.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                date,
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 11.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.circle,
                                size: 4,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Right side: status and price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isConfirmed
                                ? const Color(0xFF08864F)
                                : const Color(0xFFFFF7ED), // Peach background
                            borderRadius: BorderRadius.circular(12),
                            border: isConfirmed
                                ? null
                                : Border.all(
                                    color: const Color(0xFFFFEDD5),
                                    width: 1,
                                  ),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isConfirmed
                                  ? Colors.white
                                  : const Color(0xFFC2410C), // Orange text
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          price,
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
