import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/user_home_controller.dart';

class ExploreAllFilters extends StatelessWidget {
  final UserHomeController controller;
  const ExploreAllFilters({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label & Reset Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => controller.resetFilters(),
                icon: const Icon(
                  Icons.tune_rounded,
                  color: ColorConstant.appColor,
                  size: 16,
                ),
                label: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstant.appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        
        // Horizontal list of pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Pill 1: Verified Only
              _buildFilterPill(
                label: 'Verified Only',
                isSelected: controller.isVerifiedOnly,
                showCheck: true,
                onTap: () => controller.toggleVerifiedOnly(),
              ),
              const SizedBox(width: 10),

              // Pill 2: Available Now
              _buildFilterPill(
                label: 'Available Now',
                isSelected: controller.isAvailableNow,
                showCheck: false,
                onTap: () => controller.toggleAvailableNow(),
                isGreyStyle: true,
              ),
              const SizedBox(width: 10),

              // Pill 3: Panchakarma
              _buildFilterPill(
                label: 'Panchakarma',
                isSelected: controller.isPanchakarmaSelected,
                showCheck: false,
                onTap: () => controller.togglePanchakarma(),
                isBorderedStyle: true,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPill({
    required String label,
    required bool isSelected,
    required bool showCheck,
    required VoidCallback onTap,
    bool isGreyStyle = false,
    bool isBorderedStyle = false,
  }) {
    // Determine colors based on selection and style
    Color bgColor;
    Color textColor;
    Border? border;

    if (isSelected) {
      bgColor = ColorConstant.appColor;
      textColor = Colors.white;
    } else {
      if (isGreyStyle) {
        bgColor = const Color(0xFFE2E7E4);
        textColor = ColorConstant.greyColor;
      } else if (isBorderedStyle) {
        bgColor = Colors.white;
        textColor = ColorConstant.greyColor;
        border = Border.all(color: Colors.grey.shade300, width: 1.5);
      } else {
        bgColor = Colors.white;
        textColor = ColorConstant.greyColor;
        border = Border.all(color: Colors.grey.shade300, width: 1.5);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCheck && isSelected) ...[
              const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
