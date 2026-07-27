import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/help_support_controller.dart';

class SupportChips extends StatelessWidget {
  final HelpSupportController controller;

  const SupportChips({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: controller.categories.map((category) {
          final isSelected = controller.selectedCategory == category;
          return GestureDetector(
            onTap: () => controller.selectCategory(category),
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? ColorConstant.appColor : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? ColorConstant.appColor : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : ColorConstant.greyColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
