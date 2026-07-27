import 'package:flutter/material.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/cancel_confirmation_controller.dart';

class ConfirmationButtons extends StatelessWidget {
  final CancelConfirmationController controller;
  const ConfirmationButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonButton(
          height: 55,
          borderRadius: 20,
          buttonText: 'Return to Dashboard',
          fontWeight: FontWeight.bold,
          bgColor: ColorConstant.appColor,
          onTap: () => controller.returnToDashboard(context),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => controller.contactSupport(context),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 55,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD1FAE5), width: 1.5),
            ),
            child: const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.appColor,
                fontFamily: 'Afacad',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
