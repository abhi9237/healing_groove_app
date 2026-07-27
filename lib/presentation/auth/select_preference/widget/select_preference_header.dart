import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';

class SelectPreferenceHeader extends StatelessWidget {
  const SelectPreferenceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Your wellness preferences',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,

            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Help us recommend the best sessions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorConstant.greyColor,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 110,
          height: 2.5,
          decoration: BoxDecoration(
            color: ColorConstant.appColor,
            borderRadius: BorderRadius.circular(1.5),
          ),
        ),
      ],
    );
  }
}
