import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_bottom_nav_controller.dart';
import 'package:healing/controller/usercontroller/user_bottom_nav_controller.dart';
import '../core/color_constant/color_constant.dart';

class CommonAppBar extends StatelessWidget {
  final String? title;
  final bool? showBackButton;
  final Color? titleColor;
  final bool? showMenuButton;
  final VoidCallback? onMenuPressed;

  const CommonAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.titleColor,
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String fullName = HiveStorageService.getUserName() ?? '';
    final String firstName = fullName.trim().isEmpty
        ? ''
        : fullName.trim().split(' ').first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (showMenuButton == true)
                  IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: ColorConstant.lightBlackColor,
                      size: 26,
                    ),
                    onPressed:
                        onMenuPressed ??
                        () {
                          Scaffold.of(context).openDrawer();
                        },
                  )
                else if (showBackButton == true)
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorConstant.lightBlackColor,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                showMenuButton == true || showBackButton == true
                    ? const SizedBox(width: 8)
                    : const SizedBox.shrink(),

                Expanded(
                  child: Text(
                   // 'A jenkdc jwe ckdw c kcas kcj dw ekdekd e kde',
                    title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: titleColor ?? ColorConstant.appColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5),

          Row(
            children: [
              // Stack(
              //   children: [
              //     IconButton(
              //       icon: const Icon(
              //         Icons.notifications_none_rounded,
              //         color: ColorConstant.lightBlackColor,
              //         size: 28,
              //       ),
              //       onPressed: () {},
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

              GestureDetector(
                onTap: () {
                  try {
                    if (Get.isRegistered<WellnessBottomNavController>()) {
                      Get.find<WellnessBottomNavController>().changeIndex(3);
                    } else if (Get.isRegistered<UserBottomNavController>()) {
                      Get.find<UserBottomNavController>().changeIndex(3);
                    }
                  } catch (_) {}
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorConstant.appColor,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    firstName.isNotEmpty
                        ? firstName.substring(0, 1).toUpperCase()
                        : 'W',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
