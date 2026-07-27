import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';

class AuthSelectionHeader extends StatelessWidget {
  const AuthSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Afacad',
              height: 1.25,
            ),
            children: [
              TextSpan(
                text: 'How would you like\n',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              TextSpan(
                text: 'to join us?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: 45,
          height: 1.8,
          decoration: BoxDecoration(
            color: ColorConstant.appColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Select your path to start your personalized\nwellness journey today.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
