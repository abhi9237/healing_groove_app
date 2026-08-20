import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/controller/usercontroller/enquiries_and_bookings_controller.dart';
import '../../../../common/common_app_bar.dart';
import 'widget/enquiries_header.dart';
import 'widget/enquiry_card.dart';
import 'widget/status_guide_widget.dart';
import 'widget/enquiries_and_bookings_shimmer.dart';

class EnquiriesAndBookings extends StatelessWidget {
  const EnquiriesAndBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<EnquiriesAndBookingsController>(
          init: EnquiriesAndBookingsController(),
          builder: (controller) {
            return CustomScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const CommonAppBar(
                      title: 'Enquiries & Bookings',
                      showBackButton: false,
                    ),
                  ),
                ),

                // 2. Description text - Scrolls
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: EnquiriesHeaderDescription(),
                  ),
                ),

                // 3. Pinned Search & Filter Controls
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PinnedSearchFiltersDelegate(
                    height: 140.0,
                    child: EnquiriesSearchFilters(controller: controller),
                  ),
                ),

                // 4. Scrollable Enquiry Cards
                controller.isLoading.value
                    ? const SliverToBoxAdapter(
                        child: EnquiriesAndBookingsShimmer(),
                      )
                    : controller.filteredEnquiries.isEmpty
                    ? const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 220,
                          child: Center(
                            child: Text(
                              'No enquiries found.',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.greyColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            if (index == controller.filteredEnquiries.length) {
                              return Obx(() {
                                if (controller.isLoadMore.value) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                            final enquiry = controller.filteredEnquiries[index];
                            return EnquiryCard(
                              enquiry: enquiry,
                              onTap: () {
                                context.push(
                                  '${RouteConstant.enquiriesDetail}/${enquiry.id}',
                                  extra: {'enquiryDetail': enquiry},
                                );
                              },
                            );
                          }, childCount: controller.filteredEnquiries.length + 1),
                        ),
                      ),

                // 5. Status Guide (shows at the end of the scroll list)
                if (controller.showStatusGuide)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: StatusGuideWidget(controller: controller),
                    ),
                  ),

                // 6. Bottom spacing to clear floating bottom navigation bar
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Persistent Header Delegate to handle pinning and background coverage
class _PinnedSearchFiltersDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _PinnedSearchFiltersDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      // Keep background color matching the app scaffold to hide cards scrolling underneath
      color: const Color(0xFFF9FBF9),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedSearchFiltersDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
