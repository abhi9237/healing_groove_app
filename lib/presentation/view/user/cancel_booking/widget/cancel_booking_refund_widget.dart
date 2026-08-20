import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:healing/common/common_methods.dart';

import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/cancel_booking_controller.dart';

class CancelBookingRefundWidget extends StatelessWidget {
  final CancelBookingController controller;
  const CancelBookingRefundWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final amount = controller.refundPreviewAmount ?? 0;
    final percent = controller.refundPercent ?? 0;
    final isRefundable = amount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Refund',
              style: TextStyle(
                color: ColorConstant.lightBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Afacad',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isRefundable ? const Color(0xFFECFDF3) : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isRefundable ? const Color(0xFFD0F5E0) : const Color(0xFFFEE2E2)),
              ),
              child: Row(
                children: [
                  Icon(
                    isRefundable ? Icons.check_circle_outline_rounded : Icons.report_problem_outlined,
                    color: isRefundable ? const Color(0xFF027A48) : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isRefundable ? '$percent% REFUND' : 'NO REFUND',
                    style: TextStyle(
                      color: isRefundable ? const Color(0xFF027A48) : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Afacad',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRefundable ? const Color(0xFFECFDF3) : const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isRefundable ? const Color(0xFFD0F5E0) : const Color(0xFFFEE2E2)),
          ),
          child: RichText(
            text: TextSpan(
              text: 'According to the cancellation policy, this booking is ',
              style: TextStyle(
                color: isRefundable ? const Color(0xFF027A48) : const Color(0xFFB91C1C),
                fontSize: 14,
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: isRefundable
                      ? 'eligible for a $percent% cash refund of ${formatIndianPrice(amount)}.'
                      : 'not eligible for a cash refund.',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Reason for cancellation (optional)',
          style: TextStyle(
            color: ColorConstant.greyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Afacad',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.reasonController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Let us know why you're cancelling...",
            hintStyle: TextStyle(
              color: ColorConstant.greyColor.withValues(alpha: 0.4),
              fontFamily: 'Afacad',
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorConstant.appColor),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: controller.isPolicyAccepted.value,
                  activeColor: ColorConstant.appColor,
                  onChanged: (val) => controller.togglePolicyAcceptance(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'I understand the applicable cancellation policy and wish to proceed with the cancellation.',
                style: TextStyle(
                  color: ColorConstant.greyColor,
                  fontSize: 14,
                  fontFamily: 'Afacad',
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
