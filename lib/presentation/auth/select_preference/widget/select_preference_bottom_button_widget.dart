import 'package:flutter/material.dart';
import '../../../../common/common_button.dart';
import '../../../../controller/usercontroller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';

class SelectPreferenceBottomButtonWidget extends StatelessWidget {
  final CreateAccountController controller;
  const SelectPreferenceBottomButtonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'Back',
                style: TextStyle(
                  color: ColorConstant.appColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Lets Start Button (Filled)
        Expanded(
          flex: 3,
          child: CommonButton(
            height: 55,
            buttonText: 'Lets Start',
            fontWeight: FontWeight.bold,
            borderRadius: 22,
            onTap: () {
              controller.onTapLetsStart(context);
            },
          ),
        ),
      ],
    );
  }
}
