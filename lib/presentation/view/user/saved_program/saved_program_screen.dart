import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_methods.dart';
import 'package:healing/controller/usercontroller/saved_program_controller.dart';
import 'widget/saved_program_card.dart';
import 'widget/saved_program_shimmer.dart';
import 'widget/saved_program_empty_state.dart';

class SavedProgramScreen extends StatelessWidget {
  const SavedProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: false,
        child: GetBuilder<SavedProgramController>(
          init: SavedProgramController(),
          builder: (controller) {
            return AppLoader(
              isLoading: controller.isSaveLoading,
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonAppBar(
                      title: 'Saved Centres',
                      showBackButton: true,
                    ),
                    Expanded(
                      child: controller.isLoading.value
                          ? const SingleChildScrollView(
                              padding: EdgeInsets.only(bottom: 24.0),
                              child: SavedProgramShimmer(),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Column(
                                children: [
                                  if (controller.savedCentres.isEmpty)
                                    const SavedProgramEmptyState()
                                  else
                                    ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller.savedCentres.length,
                                      itemBuilder: (context, index) {
                                        final item = controller.savedCentres[index];
                                        return SavedProgramCard(
                                          id: item.id ?? 0,
                                          title: item.name ?? '',
                                          rating: item.rating ?? 0.0,
                                          ratingCount: item.reviewCount ?? 0,
                                          location: getLocation(
                                            city: item.location?.city,
                                            country: item.location?.country,
                                            state: item.location?.state,
                                          ),
                                          duration: item.durationText ?? 'N/A',
                                          nextAvailable: item.availability ?? 'N/A',
                                          imagePath: item.image?.url ?? '',
                                          programName: item.speciality ?? 'Wellness Centre',
                                          isVerified: item.approvalStatus == 'approved',
                                          isFavorite: item.isSaved ?? false,
                                          onFavoriteTap: () {
                                            controller.toggleFavoriteCentre(item.id ?? 0);
                                          },
                                          onTapViewDetail: (){
                                            controller.onTapViewDetail(item.id ??0,context);
                                          },
                                        );
                                      },
                                    ),
                                  // const SizedBox(height: 12),
                                  // const SavedProgramProTip(),
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
