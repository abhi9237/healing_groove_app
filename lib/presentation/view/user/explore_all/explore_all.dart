import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/controller/user_home_controller.dart';
import 'package:healing/presentation/view/user/explore_all/widget/explore_all_app_bar.dart';
import 'widget/explore_all_header.dart';
import 'widget/explore_all_filters.dart';
import 'widget/explore_wellness_card.dart';

class ExploreAllUi extends StatelessWidget {
  const ExploreAllUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<UserHomeController>(
          init: UserHomeController(),
          builder: (controller) {
            final List<Map<String, dynamic>> allCentres = [
              {
                'title': 'Serenity Wellness Center',
                'rating': 4.8,
                'ratingCount': 166,
                'location': 'Kerala, India',
                'duration': '7-14 days',
                'nextAvailable': 'Available next month',
                'imagePath': ImageConstant.resortImg,
                'programName': 'Stress Relief Program',
                'isVerified': true,
                'isAvailableNow': false,
                'programType': 'Stress Relief Program',
              },
              {
                'title': 'Naturoville Wellness Resort Rishikesh',
                'rating': 4.9,
                'ratingCount': 210,
                'location': 'Rishikesh, India',
                'duration': '10-21 days',
                'nextAvailable': 'Available next week',
                'imagePath': ImageConstant.resortImg,
                'programName': 'Panchakarma Treatment',
                'isVerified': true,
                'isAvailableNow': true,
                'programType': 'Panchakarma',
              },
              {
                'title': 'Somatheeram Ayurvedic Health Resort',
                'rating': 4.7,
                'ratingCount': 185,
                'location': 'Kerala, India',
                'duration': '14-28 days',
                'nextAvailable': 'Available next month',
                'imagePath': ImageConstant.resortImg,
                'programName': 'Detox & Weight Loss',
                'isVerified': true,
                'isAvailableNow': false,
                'programType': 'Detox & Weight Loss',
              },
              {
                'title': 'Ananda in the Himalayas Resort',
                'rating': 4.9,
                'ratingCount': 320,
                'location': 'Rishikesh, India',
                'duration': '5-14 days',
                'nextAvailable': 'Available next week',
                'imagePath': ImageConstant.resortImg,
                'programName': 'Yoga & Meditation Retreat',
                'isVerified': true,
                'isAvailableNow': true,
                'programType': 'Yoga & Meditation',
              },
            ];

            final List<Map<String, dynamic>> filteredCentres = allCentres.where(
              (centre) {
                // Reason/program filter
                if (controller.selectedReason.isNotEmpty &&
                    controller.selectedReason !=
                        'e.g. Panchakarma, Yoga, Stress Relief...') {
                  // If it is 'Yoga & Meditation', check match
                  final String searchType = controller.selectedReason;
                  if (centre['programType'] != searchType) {
                    return false;
                  }
                }

                // Destination filter
                if (controller.selectedDestination.isNotEmpty &&
                    controller.selectedDestination !=
                        'Search city or region...') {
                  final String dest = controller.selectedDestination
                      .split(',')[0]
                      .toLowerCase();
                  if (!centre['location'].toString().toLowerCase().contains(
                    dest,
                  )) {
                    return false;
                  }
                }

                // Verified Only filter
                if (controller.isVerifiedOnly && !centre['isVerified']) {
                  return false;
                }

                // Available Now filter
                if (controller.isAvailableNow && !centre['isAvailableNow']) {
                  return false;
                }

                // Panchakarma filter tag
                if (controller.isPanchakarmaSelected &&
                    centre['programType'] != 'Panchakarma') {
                  return false;
                }

                return true;
              },
            ).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row (Back Button)
                ExploreAllAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Green Search Card
                        ExploreAllHeader(controller: controller),

                        // Filters Section
                        ExploreAllFilters(controller: controller),

                        // Wellness Centres List
                        filteredCentres.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 40.0,
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    'No wellness centres found matching the selected filters.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstant.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 40.0),
                                itemCount: filteredCentres.length,
                                itemBuilder: (context, index) {
                                  final centre = filteredCentres[index];
                                  return ExploreWellnessCard(
                                    title: centre['title'],
                                    rating: centre['rating'],
                                    ratingCount: centre['ratingCount'],
                                    location: centre['location'],
                                    duration: centre['duration'],
                                    nextAvailable: centre['nextAvailable'],
                                    imagePath: centre['imagePath'],
                                    programName: centre['programName'],
                                    isVerified: centre['isVerified'],
                                  );
                                },
                              ),
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
