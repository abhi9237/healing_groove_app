import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/user_home_controller.dart';
import 'package:healing/presentation/view/user/user_home/widget/user_home_stats.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../core/route/route_constant/route_constant.dart';

class TitleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final UserHomeController controller;
  final BuildContext context;


  TitleHeaderDelegate(this.context, this.controller);

  static const double _statsHeight = 310;
  static const double _titleHeight = 140;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final isCollapsed = shrinkOffset > maxExtent - minExtent;
    return Container(
      color: Color.lerp(Colors.transparent, ColorConstant.whiteColor, progress),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          /// Animated Stats
          ClipRect(
            child: Align(
              heightFactor: 1 - progress,
              child: Opacity(
                opacity: 1 - progress,
                child: Transform.translate(
                  offset: Offset(0, -30 * progress),
                  child:  UserHomeStats(
                    controller: controller,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 15 * (1 - progress)),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isCollapsed ? 60 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorConstant.appColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Discover Wellness Centres',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),

                            Text(
                              'Browse live centres and open their programs to book directly.',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorConstant.greyColor.withOpacity(
                                  0.85,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Opacity(
                    opacity: 1 - progress,
                    child: isCollapsed
                        ? SizedBox()
                        : Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () =>
                                    context.push(RouteConstant.exploreAll),
                                child: const Row(
                                  children: [
                                    Text(
                                      'Explore all',
                                      style: TextStyle(
                                        color: ColorConstant.appColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: ColorConstant.appColor,
                                      size: 16,
                                    ),
                                  ],
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

  @override
  double get maxExtent => _statsHeight;

  @override
  double get minExtent => _titleHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
