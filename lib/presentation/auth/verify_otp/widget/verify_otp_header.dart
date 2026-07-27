import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';

class VerifyOtpHeader extends StatelessWidget {
  final String email;

  const VerifyOtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Envelope Icon Container
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE2F7EB),
            border: Border.all(color: ColorConstant.appColor, width: 1.8),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.mail_rounded,
            color: ColorConstant.appColor,
            size: 46,
          ),
        ),
        const SizedBox(height: 28),

        // Title
        const Text(
          'Verify your email',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'We sent a 6-digit code to $email',
            textAlign: TextAlign.center,
            style: const TextStyle(
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
