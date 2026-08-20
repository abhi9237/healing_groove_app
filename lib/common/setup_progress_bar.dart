import 'package:flutter/material.dart';
import '../core/color_constant/color_constant.dart';

class SetupProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double progress; // Between 0.0 and 1.0

  const SetupProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final int percentage = (progress * 100).round();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $currentStep of $totalSteps',
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstant.appColor,
              ),
            ),
            Text(
              '$percentage% complete',
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstant.appColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 6,
            width: double.infinity,
            color: const Color(0xFFE2E8F0),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstant.appColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
