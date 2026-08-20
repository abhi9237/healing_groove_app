import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_bottom_nav_controller.dart';

class WellnessBottomBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final WellnessBottomNavController controller;

  const WellnessBottomBar({
    super.key,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Background Pill Container
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildItem(0)),
                Expanded(child: _buildItem(1)),
                const SizedBox(width: 72), // Spacer gap for central FAB
                Expanded(child: _buildItem(2)),
                Expanded(child: _buildItem(3)),
              ],
            ),
          ),
          // Central FAB with White Border
          Positioned(
            top: -22, // Overlap above the pill bar
            child: GestureDetector(
              onTap: () => controller.onFabPressed(context),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: ColorConstant.appColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.whiteColor,
                    width: 3.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: ColorConstant.whiteColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final isSelected = index == controller.currentIndex;
    final item = controller.items[index];

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? item['selectedIcon'] as IconData : item['icon'] as IconData,
            color: isSelected ? ColorConstant.whiteColor : ColorConstant.whiteColor.withValues(alpha: 0.7),
            size: isSelected ? 24 : 22,
          ),
          const SizedBox(height: 3),
          Text(
            item['label'] as String,
            style: TextStyle(
              color: isSelected ? ColorConstant.whiteColor : ColorConstant.whiteColor.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
