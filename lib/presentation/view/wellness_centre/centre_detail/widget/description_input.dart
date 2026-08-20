import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class DescriptionInput extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Description',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorConstant.lightBlackColor,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CommonTextFormFilled(
          hintText: 'Briefly describe your center, mission, and unique offerings...',
          controller: controller,
          maxLines: 4,
          height: 120,
        ),
      ],
    );
  }
}
