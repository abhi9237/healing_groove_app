import 'package:flutter/material.dart';
import '../../../../../common/common_text_form_filled.dart';
import '../../../../../core/color_constant/color_constant.dart';

class FacilitiesAmenitiesInput extends StatelessWidget {
  final TextEditingController controller;

  const FacilitiesAmenitiesInput({
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
            text: 'Facilities & Amenities',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorConstant.lightBlackColor,
            ),
            children: [
              TextSpan(
                text: ' (comma separated)',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CommonTextFormFilled(
          hintText: 'e.g Spa, Swimming pool, Organic Cafe',
          controller: controller,
        ),
      ],
    );
  }
}
