import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class CenterNameInput extends StatelessWidget {
  final TextEditingController controller;

  const CenterNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Center Name',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.9),
            ),
          ),
        ),
        const SizedBox(height: 8),
        CommonTextFormFilled(
          controller: controller,
          hintText: 'Enter your center name',
        ),
      ],
    );
  }
}
