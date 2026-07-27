import 'package:flutter/material.dart';

import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/cancel_booking_controller.dart';

class CancelBookingStatusWidget extends StatelessWidget {
  final CancelBookingController controller;
  const CancelBookingStatusWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildInfoRow(
          icon: Icons.calendar_today_outlined,
          title: 'Booking Date',
          value: controller.bookingDate,
        ),
        _buildInfoRow(
          icon: Icons.business_outlined,
          title: 'Program Start',
          value: controller.programStart,
        ),
        _buildInfoRow(
          icon: Icons.watch_later_outlined,
          title: 'Cancellation Date',
          value: controller.cancellationDate,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Applicable Policy',
                style: TextStyle(
                  color: ColorConstant.greyColor.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Afacad',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.applicablePolicyRule ?? 'Cancelled less than 24 hours before start — No refund',
                style: TextStyle(
                  color: ColorConstant.greyColor.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Afacad',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorConstant.greyColor.withValues(alpha: 0.7),
            size: 22,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: ColorConstant.greyColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Afacad',
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: ColorConstant.lightBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Afacad',
            ),
          ),
        ],
      ),
    );
  }
}
