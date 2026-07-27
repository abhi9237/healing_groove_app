import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/user_home_controller.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../../common/common_methods.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../core/image_constant/image_constant.dart';

class UserHomeWellnessCentres extends StatelessWidget {
  final UserHomeController controller;
  const UserHomeWellnessCentres({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 120),
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.centerList.length + 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, i) {
        if (i == controller.centerList.length) {
          return Obx(() {
            if (controller.isLoadMore.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorConstant.appColor,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          });
        }
        DocModel centerData = controller.centerList[i];
        return WellNessCenterWidget(
          centreData: centerData,
          onTap: () {
            controller.onTapViewProgram(context, centerData.id ?? 0);
          },
        );
      },
    );
  }
}

class WellNessCenterWidget extends StatelessWidget {
  final DocModel centreData;
  final VoidCallback onTap;
  const WellNessCenterWidget({
    super.key,
    required this.centreData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with Overlay Badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: CustomImageView(
                          url: centreData.image?.url ?? '',
                          fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          errorWidget: (_, _, _) => Image.asset(
                            ImageConstant.imageNotFound,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      // "New" Badge Overlay
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.appColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Card details text
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          centreData.name?.capitalizeFirst ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: ColorConstant.appColor,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              getLocation(
                                city: centreData.location?.city,
                                country: centreData.location?.country,
                                state: centreData.location?.state,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.greyColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorConstant.appColor,
                            ),
                            child: Text(
                              'View Program & Book',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
