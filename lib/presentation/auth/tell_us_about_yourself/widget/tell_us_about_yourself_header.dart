import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';

class TellUsAboutYourselfHeader extends StatelessWidget {
  const TellUsAboutYourselfHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Tell us about yourself',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,

            height: 1.25,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Help us personalise your experience',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorConstant.greyColor,
          ),
        ),
      ],
    );
  }
}
