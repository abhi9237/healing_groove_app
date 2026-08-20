import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/my_journey_detail_controller.dart';

class MyJourneyStatusHeader extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyStatusHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String s = controller.status.toUpperCase();
    final bool isCancelled = s == 'CANCELLED';
    final bool isCompleted = s == 'COMPLETED';

    if (!isCancelled && !isCompleted) {
      return const SizedBox.shrink();
    }

    final Color primaryColor = isCancelled ? const Color(0xFFD32F2F) : const Color(0xFF08864F);
    final Color bgColor = isCancelled ? const Color(0xFFFDF2F2) : const Color(0xFFECFDF5);
    final Color borderColor = isCancelled ? const Color(0xFFFCA5A5) : const Color(0xFF6EE7B7);
    final IconData icon = isCancelled ? Icons.cancel_outlined : Icons.check_circle_outline_rounded;
    final String title = isCancelled ? 'Booking Canceled' : 'Booking Completed';
    final String dateLabel = isCancelled ? 'Canceled on' : 'Completed on';
    
    final String dateValue = isCancelled 
        ? (controller.cancelledDate.isNotEmpty ? controller.cancelledDate : controller.initiatedDate)
        : (controller.completedDate.isNotEmpty ? controller.completedDate : controller.checkOutDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
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
            // Status Icon with background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCancelled ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Booking ID: #${controller.bookingId}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dateLabel $dateValue',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.greyColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
