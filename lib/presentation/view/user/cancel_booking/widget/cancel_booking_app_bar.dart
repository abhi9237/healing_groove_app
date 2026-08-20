import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../common/common_app_bar.dart';
import 'package:healing/controller/usercontroller/cancel_booking_controller.dart';

class CancelBookingAppBar extends StatelessWidget {
  final CancelBookingController controller;
  const CancelBookingAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonAppBar(title: 'Cancel Booking',),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,),
          child: RichText(
            text: TextSpan(
              text: 'You are requesting to cancel ',
              style: const TextStyle(
                color: ColorConstant.greyColor,
                fontSize: 16,
                fontFamily: 'Afacad',
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: 'Booking #${controller.bookingId}.',
                  style: const TextStyle(
                    color: ColorConstant.lightBlackColor,
                    fontSize: 16,
                    fontFamily: 'Afacad',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
