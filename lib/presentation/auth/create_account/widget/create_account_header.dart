import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';

class CreateAccountHeader extends StatelessWidget {
  const CreateAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Create your Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Fill in your details to get started',
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
