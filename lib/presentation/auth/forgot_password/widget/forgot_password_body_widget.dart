import 'package:flutter/material.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../../../../controller/usercontroller/forgot_password_controller.dart';

class ForgotPasswordBodyWidget extends StatelessWidget {
  final ForgotPasswordController controller;

  const ForgotPasswordBodyWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: ColorConstant.whiteColor.withValues(alpha: 0.4),
        border: Border.all(
          color: ColorConstant.borderLightGreenColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        spacing: 15,
        children: [
          if (controller.stepIndex == 0) ...[
            // Step 0: Email Entry
            CommonTextFormFilled(
              controller: controller.emailController,
              hintText: 'Email Address',
              prefixIcon: ImageConstant.emailIcon,
            ),
            const SizedBox(height: 10),
            CommonButton(
              height: 55,
              buttonText: 'Send OTP',
              fontWeight: FontWeight.bold,
              borderRadius: 20,
              onTap: () => controller.sendOtp(context),
            ),
          ] else if (controller.stepIndex == 1) ...[
            // Step 1: OTP verification
            CommonTextFormFilled(
              controller: controller.otpController,
              hintText: 'Enter OTP',
              prefixIcon: ImageConstant.lockIcon,
            ),
            const SizedBox(height: 10),
            CommonButton(
              height: 55,
              buttonText: 'Verify OTP',
              fontWeight: FontWeight.bold,
              borderRadius: 20,
              onTap: () => controller.verifyOtp(context),
            ),
            const SizedBox(height: 12),
            if (controller.timerSeconds > 0)
              Text(
                "Resend code in 0:${controller.timerSeconds.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.greyColor,
                ),
              )
            else
              InkWell(
                onTap: () => controller.sendOtp(context),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sync_rounded,
                        color: ColorConstant.appColor,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: ColorConstant.appColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ] else if (controller.stepIndex == 2) ...[
            // Step 2: Three text fields: Email, New Password, Confirm Password
            CommonTextFormFilled(
              readOnly: true,
              controller: controller.emailController,
              hintText: 'Email Address',
              prefixIcon: ImageConstant.emailIcon,
            ),
            CommonTextFormFilled(
              controller: controller.newPasswordController,
              hintText: 'New Password',
              prefixIcon: ImageConstant.lockIcon,
              suffixIcon: ImageConstant.passwordHideIcon,
              obscureText: true,
            ),
            CommonTextFormFilled(
              controller: controller.confirmPasswordController,
              hintText: 'Confirm Password',
              prefixIcon: ImageConstant.lockIcon,
              suffixIcon: ImageConstant.passwordHideIcon,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            CommonButton(
              height: 55,
              buttonText: 'Submit',
              fontWeight: FontWeight.bold,
              borderRadius: 20,
              onTap: () => controller.resetPassword(context),
            ),
          ],

          // Navigation/Back options
          GestureDetector(
            onTap: () => controller.navigateBackStep(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                controller.stepIndex == 0 ? 'Back to Sign In' : 'Go Back',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
