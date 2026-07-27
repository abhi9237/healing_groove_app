import 'package:flutter/material.dart';
import '../../../../controller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import 'preference_chip.dart';

class SelectPreferenceForm extends StatelessWidget {
  final CreateAccountController controller;
  const SelectPreferenceForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.adjust_rounded,
              color: ColorConstant.appColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Wellness Goals',
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
          children: controller.wellnessGoalsList
              .map(
                (label) => PreferenceChip(
                  label: label,
                  onSelected: (item) =>
                      controller.onTapSelectWellNessGoals(item,context),
                  isSelected: controller.selectedGoalsList.contains(label),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 36),

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
      ],
    );
  }
}
