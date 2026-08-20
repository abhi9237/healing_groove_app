import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class CoreSpecialityInput extends StatelessWidget {
  final TextEditingController controller;

  const CoreSpecialityInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Core Speciality',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 8),
        CommonTextFormFilled(
          hintText: 'e.g Ayurveda',
          controller: controller,
        ),
      ],
    );
  }
}
