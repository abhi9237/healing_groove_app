import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/account_progress_controller.dart';
import '../core/color_constant/color_constant.dart';


class AccountProgressBar extends StatelessWidget {
  final bool? isShowBackButton;
  const AccountProgressBar({super.key, this.isShowBackButton = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountProgressController>();

    return Obx(() {
      final bool step1Checked = controller.roleVerified.value;
      final bool step2Checked = controller.signUpVerified.value;
      final bool step3Checked = controller.preferenceVerified.value;

      final bool step1Active = !step1Checked;
      final bool step2Active = step1Checked && !step2Checked;
      final bool step3Active = step2Checked && !step3Checked;

      final Color line1Color = step1Checked
          ? ColorConstant.appColor
          : Colors.grey.shade200;
      final Color line2Color = step2Checked
          ? ColorConstant.appColor
          : Colors.grey.shade200;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Back button
            if (isShowBackButton == true)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back,
                    color: ColorConstant.lightBlackColor,
                    size: 26,
                  ),
                ),
              ),
            const SizedBox(width: 8),

            // Stepper
            Expanded(
              child: SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    // Background lines connecting the steps
                    Positioned(
                      top: 17,
                      left: 28,
                      right: 28,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2.2,
                              decoration: BoxDecoration(
                                color: line1Color,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2.2,
                              decoration: BoxDecoration(
                                color: line2Color,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Steps columns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStep(
                          isChecked: step1Checked,
                          isActive: step1Active,
                          number: '1',
                          label: 'Role',
                        ),
                        _buildStep(
                          isChecked: step2Checked,
                          isActive: step2Active,
                          number: '2',
                          label: 'Sign Up',
                        ),
                        _buildStep(
                          isChecked: step3Checked,
                          isActive: step3Active,
                          number: '3',
                          label: 'Finish',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Spacer on right to balance the back button
            const SizedBox(width: 42),
          ],
        ),
      );
    });
  }

  Widget _buildStep({
    bool isChecked = false,
    bool isActive = false,
    String? number,
    required String label,
  }) {
    Color circleColor;
    Color textColor;
    Widget child;

    if (isChecked) {
      circleColor = const Color(0xFFE2F7EB);
      textColor = ColorConstant.greyColor;
      child = const Icon(Icons.check, color: ColorConstant.appColor, size: 16);
    } else if (isActive) {
      circleColor = ColorConstant.appColor;
      textColor = ColorConstant.appColor;
      child = Text(
        number ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      circleColor = const Color(0xFFF1F3F2);
      textColor = ColorConstant.greyColor;
      child = Text(
        number ?? '',
        style: const TextStyle(
          color: Color(0xFFB0B9B4),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            border: isChecked
                ? Border.all(color: ColorConstant.appColor, width: 1.2)
                : null,
          ),
          alignment: Alignment.center,
          child: child,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
