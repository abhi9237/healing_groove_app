import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_widget.dart';
import '../../../../../common/common_button.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/cancel_booking_controller.dart';

class CancelBookingButtons extends StatelessWidget {
  final CancelBookingController controller;
  const CancelBookingButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
      ),
      child: Column(
        children: [
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CommonCircularIndicator(),
                )
              : CommonButton(
                  height: 55,
                  borderRadius: 20,
                  buttonText: 'Confirm Cancellation',
                  fontWeight: FontWeight.bold,
                  bgColor: const Color(0xFFFA6D6D),
                  onTap: () => controller.confirmCancellation(context),
                )),
          const SizedBox(height: 12),
          CommonButton(
            height: 55,
            borderRadius: 20,
            buttonText: 'Keep Booking',
            fontWeight: FontWeight.bold,
            bgColor: ColorConstant.appColor,
            onTap: () => controller.keepBooking(context),
          ),
        ],
      ),
    );
  }
}
