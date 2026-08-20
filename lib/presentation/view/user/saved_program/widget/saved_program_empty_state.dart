import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/controller/usercontroller/user_bottom_nav_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

class SavedProgramEmptyState extends StatelessWidget {
  const SavedProgramEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Heart Illustration Container
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5EE), // Very light mint green circle
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.favorite_border_rounded,
                color: ColorConstant.appColor,
                size: 72,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Title
          const Text(
            'No saved centres yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            'Start your wellness journey by saving centres you love for quick access and comparison.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorConstant.greyColor.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),

          // Explore Centres Button (with right arrow icon)
          ElevatedButton(
            onPressed: () {
              if (Get.isRegistered<UserBottomNavController>()) {
                Get.find<UserBottomNavController>().changeIndex(0);
              }
              context.go(RouteConstant.userDashboard);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF065F37), // Premium dark green
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Explore Centres',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
