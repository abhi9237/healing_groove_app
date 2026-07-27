import 'package:flutter/material.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/edit_profile_controller.dart';

import '../../../../auth/select_preference/widget/preference_chip.dart';

class EditWellnessGoalsCard extends StatelessWidget {
  final EditProfileController controller;

  const EditWellnessGoalsCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            children: [
              const Icon(
                Icons.adjust_rounded, // Target/bullseye icon representation
                color: ColorConstant.appColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Wellness Goals',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ColorConstant.appColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '(optional — pick any)',
                style: TextStyle(

                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.greyColor.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Wrapping list of goals
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: controller.allGoals.map((goal) {
              final isSelected = controller.selectedGoals.contains(goal);
              return GestureDetector(
                onTap: () => controller.toggleGoalSelection(goal),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorConstant.appColor : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? ColorConstant.appColor : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    goal,
                    style: TextStyle(

                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : ColorConstant.greyColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite_border_rounded,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Preferred Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '(optional — pick any)',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.greyColor.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.preferredActivitiesList
                .map(
                  (label) => PreferenceChip(
                label: label,
                onSelected: (item) =>
                    controller.onTapSelectPreferredActivities(item,context),
                isSelected: controller.selectedPreferredActivitiesList
                    .contains(label),
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 16),
          // Update Preferences button (Outlined Green)
          controller.isLoadingPreferences.value ? CommonCircularIndicator():
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => controller.onTapUpdatePreferences(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorConstant.appColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Update Preferences',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
