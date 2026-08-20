import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/my_journey_controller.dart';
import 'widget/my_journey_app_bar.dart';
import 'widget/my_journey_tab_bar.dart';
import 'widget/my_journey_card.dart';
import 'widget/my_journey_shimmer.dart';

class MyJourneyUi extends StatelessWidget {
  const MyJourneyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<MyJourneyController>(
          init: MyJourneyController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const MyJourneyAppBar(),
                ),
                const SizedBox(height: 12),
                MyJourneyTabBar(controller: controller),
                const SizedBox(height: 8),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.refreshBookings,
                    color: ColorConstant.appColor,
                    child: Obx(() {
                      final bookingsList = controller.filteredBookings;

                      if (controller.isLoading.value) {
                        return const MyJourneyShimmer();
                      }

                      if (bookingsList.isEmpty) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: const Center(
                                child: Text(
                                  'No journeys found in this section.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.greyColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      final int itemCount = controller.isMoreLoading.value
                          ? bookingsList.length + 1
                          : bookingsList.length;

                      return ListView.builder(
                        controller: controller.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.only(bottom: 110.0),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          if (index == bookingsList.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0),
                              child: CommonCircularIndicator(),
                            );
                          }
                          return MyJourneyCard(
                            booking: bookingsList[index],
                            controller: controller,
                          );
                        },
                      );
                    }),
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
