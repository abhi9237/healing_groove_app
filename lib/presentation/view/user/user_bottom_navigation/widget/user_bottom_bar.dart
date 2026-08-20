import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/user_bottom_nav_controller.dart';

class UserBottomBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final UserBottomNavController controller;

  const UserBottomBar({
    super.key,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.only(topLeft:Radius.circular(30) ,topRight:Radius.circular(30) ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.whiteColor,
            blurRadius:2,
            offset: const Offset(0, 20),
            spreadRadius: 3
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: ColorConstant.appColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.appColor.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(controller.items.length, (index) {
            final isSelected = index == controller.currentIndex;
            final item = controller.items[index];

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: isSelected
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 7)
                    : const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorConstant.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: isSelected
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            item['selectedIcon'] as String,
                            color: ColorConstant.appColor,
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['label'] as String,
                            style: const TextStyle(
                              color: ColorConstant.appColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            item['unselectedIcon'] as String,
                            color: ColorConstant.whiteColor,
                            height: 20,
                            width: 20,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['label'] as String,
                            style: const TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
