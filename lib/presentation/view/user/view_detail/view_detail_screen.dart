import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../common/common_app_bar.dart';
import 'package:healing/controller/usercontroller/view_detail_controller.dart';
import '../../../../common/common_methods.dart';
import 'widget/view_detail_gallery.dart';
import 'widget/view_detail_pricing_card.dart';
import 'widget/view_detail_why_choose.dart';
import 'widget/view_detail_programs.dart';
import 'widget/view_detail_reviews.dart';
import 'package:healing/common/app_loader.dart';

class ViewDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  const ViewDetailScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: GetBuilder<ViewDetailController>(
        init: ViewDetailController(argsData: data),
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isSaveLoading,
            child: CommonAppBackground(
              child: Column(
                children: [
                  CommonAppBar(title: 'View Details'),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ViewDetailGallery(controller: controller),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              children: [
                                _buildBadge(
                                  text:
                                      "${controller.centerDetail.approvalStatus == 'approved' ? '✓' : ''} VERIFIED CENTRE",
                                  bgColor:
                                      controller.centerDetail.approvalStatus ==
                                          'approved'
                                      ? Color(0xFFE4F3EC)
                                      : Color(0xFFF0F1F0),
                                  textColor:
                                      controller.centerDetail.approvalStatus ==
                                          'approved'
                                      ? ColorConstant.appColor
                                      : ColorConstant.greyColor,
                                ),
                                const SizedBox(width: 8),
                                _buildBadge(
                                  text: 'ENGLISH FRIENDLY',
                                  bgColor: const Color(0xFFF0F1F0),
                                  textColor: ColorConstant.greyColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                          .centerDetail
                                          .name
                                          ?.capitalizeFirst ??
                                      '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.lightBlackColor,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: ColorConstant.appColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      getLocation(
                                        city: controller
                                            .centerDetail
                                            .location
                                            ?.city,
                                        country: controller
                                            .centerDetail
                                            .location
                                            ?.country,
                                        state: controller
                                            .centerDetail
                                            .location
                                            ?.state,
                                      ),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstant.greyColor
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFEBB81A),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      (controller.centerDetail.rating != null &&
                                              controller.centerDetail.rating! >
                                                  0)
                                          ? '${controller.centerDetail.rating} (${controller.centerDetail.reviewCount} ${controller.centerDetail.reviewCount == 1 ? 'review' : 'reviews'})'
                                          : '',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstant.greyColor
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          //
                          // // Pricing / Contact card
                          ViewDetailPricingCard(controller: controller),
                          const SizedBox(height: 16),
                          //
                          // // Overview
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.lightBlackColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller.centerDetail.description ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.greyColor.withValues(
                                      alpha: 0.9,
                                    ),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          //
                          // // Why Choose
                          ViewDetailWhyChoose(controller: controller),
                          //
                          const SizedBox(height: 8),
                          //
                          // Healing Programs
                          ViewDetailPrograms(controller: controller),
                          const SizedBox(height: 16),
                          //
                          // Guest Reviews
                          ViewDetailReviews(controller: controller),
                          const SizedBox(height: 80),
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
    );
  }

  Widget _buildBadge({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
