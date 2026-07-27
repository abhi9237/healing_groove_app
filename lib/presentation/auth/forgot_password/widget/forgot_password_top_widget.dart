import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';

class ForgotPasswordTopWidget extends StatelessWidget {
  final int stepIndex;

  const ForgotPasswordTopWidget({
    super.key,
    required this.stepIndex,
  });

  @override
  Widget build(BuildContext context) {
    String title = 'Forgot Password';
    String subtitle = 'Enter your email address to retrieve\nyour wellness account password.';

    if (stepIndex == 1) {
      title = 'Verify OTP';
      subtitle = 'Enter the verification code sent\nto your registered email.';
    } else if (stepIndex == 2) {
      title = 'Reset Password';
      subtitle = 'Create a new password to secure\nyour account.';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.appLogo,
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorConstant.greyColor,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
