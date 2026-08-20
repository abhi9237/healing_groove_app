import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/usercontroller/my_journey_detail_controller.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'widget/my_journey_detail_app_bar.dart';
import 'widget/my_journey_detail_payment_card.dart';
import 'widget/my_journey_detail_header.dart';
import 'widget/my_journey_detail_resort_card.dart';
import 'widget/my_journey_detail_stay_card.dart';
import 'widget/my_journey_detail_timeline.dart';
import 'widget/my_journey_detail_pricing.dart';
import 'widget/my_journey_detail_assistance.dart';
import 'widget/my_journey_status_header.dart';

class MyJourneyDetailScreen extends StatelessWidget {
  final DocModel? bookingDetail;
  const MyJourneyDetailScreen({super.key, required this.bookingDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: false,
        child: GetBuilder<MyJourneyDetailController>(
          init: MyJourneyDetailController(booking: bookingDetail),
          builder: (controller) {
            return AppLoader(
              isLoading: controller.isLoading ,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Custom Header App Bar
                    const MyJourneyDetailAppBar(),

                    // Details scrollable list
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Payment Alert card (Action Required)
                            if (controller.status.toLowerCase() == 'initiated')
                              MyJourneyDetailPaymentCard(controller: controller),

                            // Status header based on completed/cancelled or standard details
                            if (controller.status.toUpperCase() != 'CANCELLED' && controller.status.toUpperCase() != 'COMPLETED')
                              MyJourneyDetailHeader(controller: controller)
                            else
                              MyJourneyStatusHeader(controller: controller),

                            // Resort details card
                            MyJourneyDetailResortCard(controller: controller),

                            // Stay details (Check-in/Check-out dates)
                            MyJourneyDetailStayCard(controller: controller),

                            // Journey Vertical Timeline Progress
                            MyJourneyDetailTimeline(controller: controller),

                            // Pricing & Download Invoice button
                            MyJourneyDetailPricing(controller: controller),

                            // Assistance concierge block
                            MyJourneyDetailAssistance(controller: controller),

                            // Margin bottom to clear float bottom bar
                            const SizedBox(height: 110.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
