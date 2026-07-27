import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/controller/user_home_controller.dart';
import 'package:healing/presentation/view/user/user_home/widget/user_home_screen_shimmer.dart';
import 'package:healing/presentation/view/user/user_home/widget/user_home_top_delegate_view.dart';
import 'widget/user_home_header.dart';
import 'widget/user_home_stats.dart';
import 'widget/user_home_wellness_centres.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        isSafeAreaUse: false,
        child: GetBuilder<UserHomeController>(
          init: UserHomeController(),
          builder: (controller) {
            return controller.isLoading.value
                ? UserHomeShimmer()
                : CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller.scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: UserHomeHeader(),
                        ),
                      ),

                      SliverPersistentHeader(
                        pinned: true,
                        delegate: TitleHeaderDelegate(context, controller),
                        // pinned: true,floating: true,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return UserHomeWellnessCentres(
                              key: controller.wellnessCentresKey,
                              controller: controller,
                            );
                          },
                          childCount: 1,
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
