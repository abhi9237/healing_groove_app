import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/my_journey_controller.dart';

class MyJourneyTabBar extends StatelessWidget {
  final MyJourneyController controller;

  const MyJourneyTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ['All Journey', 'Confirmed', 'Completed'];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final bool isActive = controller.activeTabIndex == index;
          
          return GestureDetector(
            onTap: () => controller.changeTab(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    color: isActive
                        ? ColorConstant.appColor
                        : ColorConstant.greyColor.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 3,
                  width: 80,
                  decoration: BoxDecoration(
                    color: isActive ? ColorConstant.appColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
