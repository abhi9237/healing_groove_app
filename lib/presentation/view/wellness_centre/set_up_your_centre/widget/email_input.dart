import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const EmailInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorConstant.greyColor.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 8),
        CommonTextFormFilled(
          hintText: 'Enter your email',
          readOnly: controller.text.isNotEmpty ? true : false,
          controller: controller,
        ),
      ],
    );
  }
}
