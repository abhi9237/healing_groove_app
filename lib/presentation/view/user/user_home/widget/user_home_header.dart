import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../../../../../controller/usercontroller/user_bottom_nav_controller.dart';
import '../../../../../controller/wellnesscentrecontroller/wellness_bottom_nav_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class UserHomeHeader extends StatelessWidget {
  const UserHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Welcome text
           Expanded(
            child: Text(
              'Welcome back, ${HiveStorageService.getUserName()}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: ColorConstant.appColor,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Notification Bell Icon with Badge
          // Stack(
          //   children: [
          //     Container(
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //       ),
          //       child: IconButton(
          //         icon: const Icon(
          //           Icons.notifications_none_rounded,
          //           color: ColorConstant.lightBlackColor,
          //           size: 30,
          //         ),
          //         onPressed: () {},
          //       ),
          //     ),
          //     Positioned(
          //       right: 12,
          //       top: 12,
          //       child: Container(
          //         width: 8,
          //         height: 8,
          //         decoration: const BoxDecoration(
          //           color: ColorConstant.appColor,
          //           shape: BoxShape.circle,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(width: 8),

          // User Profile Image Avatar
          InkWell(
            splashColor: Colors.transparent,
            onTap: (){
              try {
                if (Get.isRegistered<WellnessBottomNavController>()) {
                  Get.find<WellnessBottomNavController>().changeIndex(3);
                } else if (Get.isRegistered<UserBottomNavController>()) {
                  Get.find<UserBottomNavController>().changeIndex(3);
                }
              } catch (_) {}
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
              ),
              child:Text(
              ( HiveStorageService.getUserName() ??'').substring(0,1),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              )
              // const CircleAvatar(
              //   radius: 22,
              //   backgroundColor: ColorConstant.lightGreenColor,
              //   backgroundImage: NetworkImage(
              //     'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
