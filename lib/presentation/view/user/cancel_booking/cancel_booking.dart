import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/presentation/view/user/cancel_booking/widget/cancel_booking_buttons.dart';
import 'package:healing/presentation/view/user/cancel_booking/widget/cancel_booking_refund_widget.dart';
import 'package:healing/presentation/view/user/cancel_booking/widget/cancel_booking_status_widget.dart';
import 'package:healing/presentation/view/user/cancel_booking/widget/cancel_booking_shimmer.dart';
import '../../../../controller/cancel_booking_controller.dart';
import 'widget/cancel_booking_app_bar.dart';

class CancelBooking extends StatelessWidget {
  final int bookingId;
  const CancelBooking({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppBackground(
        child: GetBuilder<CancelBookingController>(
          init: CancelBookingController(bookingId: bookingId),
          tag: bookingId.toString(),
          builder: (controller) {
            return Column(
              children: [
                CancelBookingAppBar(controller: controller),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: controller.isLoading.value
                        ? const CancelBookingShimmer()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CancelBookingStatusWidget(controller: controller),
                              CancelBookingRefundWidget(controller: controller),
                              CancelBookingButtons(controller: controller),
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
