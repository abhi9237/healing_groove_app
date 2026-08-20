import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/controller/usercontroller/book_program_controller.dart';
import 'package:healing/controller/usercontroller/payment_controller.dart';
import 'widget/review_booking_bottom_bar.dart';
import 'widget/review_booking_guests_card.dart';
import 'widget/review_booking_last_step_card.dart';
import 'widget/review_booking_notice_card.dart';
import 'widget/review_booking_price_breakdown_card.dart';
import 'widget/review_booking_program_details_card.dart';

class ReviewBookingScreen extends StatelessWidget {
  final controller = Get.put(PaymentController());
  ReviewBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      body: GetBuilder<BookProgramController>(
        init: BookProgramController(),
        autoRemove: false,
        builder: (progController) {
          return AppLoader(
            isLoading: progController.isLoading,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const CommonAppBar(title: 'Review Booking'),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ReviewBookingLastStepCard(),
                          const SizedBox(height: 20),
                          ReviewBookingProgramDetailsCard(
                            controller: progController,
                          ),
                          const SizedBox(height: 20),
                          ReviewBookingGuestsCard(controller: progController),
                          const SizedBox(height: 20),
                          ReviewBookingPriceBreakdownCard(
                            controller: progController,
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  ReviewBookingBottomBar(controller: progController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
