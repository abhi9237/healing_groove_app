import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/controller/usercontroller/explore_all_controller.dart';
import 'package:healing/presentation/view/user/explore_all/widget/explore_all_app_bar.dart';
import 'widget/explore_all_header.dart';
import 'widget/explore_all_filters.dart';
import 'widget/explore_wellness_card.dart';
import 'widget/explore_all_shimmer.dart';

class ExploreAllUi extends StatelessWidget {
  const ExploreAllUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<ExploreAllController>(
          init: ExploreAllController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row (Back Button)
                ExploreAllAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        // Green Search Card
                        ExploreAllHeader(controller: controller),

                        if (controller.showSearchResults) ...[
                          // Filters Section
                          ExploreAllFilters(controller: controller),

                          // Search Results List / Shimmer
                          Obx(() {
                            if (controller.isSearching.value) {
                              return const ExploreAllShimmer();
                            }

                            if (controller.filteredCenters.isEmpty) {
                              return const Center(
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
                              );
                            }

                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 80.0),
                                  itemCount: controller.filteredCenters.length,
                                  itemBuilder: (context, index) {
                                    final doc = controller.filteredCenters[index];
                                    
                                    // Formatting for the card fields
                                    final title = doc.name ?? '';
                                    final rating = (doc.rating ?? 4.5).toDouble();
                                    final ratingCount = doc.reviewCount ?? 150;
                                    final location = getLocation(
                                      city: doc.location?.city,
                                      country: doc.location?.country,
                                      state: doc.location?.state,
                                    );
                                    final duration = doc.durationText?.toString() ?? '7-14 days';
                                    final nextAvailable = doc.availability?.toString() ?? 'Available next month';
                                    final imagePath = doc.image?.url ?? ''; // fallback if empty
                                    final programName = doc.speciality ?? 'Wellness Program';
                                    final isVerified = doc.approvalStatus?.toLowerCase() == 'live' || doc.approvalStatus?.toLowerCase() == 'approved';

                                    return ExploreWellnessCard(
                                      title: title,
                                      rating: rating,
                                      ratingCount: ratingCount,
                                      location: location,
                                      duration: duration,
                                      nextAvailable: nextAvailable,
                                      imagePath: imagePath,
                                      programName: programName,
                                      isVerified: isVerified,
                                      centerId: doc.id,
                                    );
                                  },
                                ),
                                if (controller.isLoadMore.value)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          ColorConstant.appColor,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ],
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
