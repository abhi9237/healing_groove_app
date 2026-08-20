import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../common/common_button.dart';
import '../../../../common/common_methods.dart';
import '../../../../controller/usercontroller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';


class VerifyOtpForm extends StatelessWidget {
  final CreateAccountController controller;

  const VerifyOtpForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label
        const Text(
          'Enter Verification Code',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 24),

        // OTP Text Fields (6 circles)
        OtpTextField(
          numberOfFields: 6,
          showFieldAsBox: true,
          borderRadius: BorderRadius.circular(50.0),
          fieldWidth: 54.0,
          filled: true,
          fillColor: const Color(0xFFF1F3F2),
          focusedBorderColor: ColorConstant.appColor,
          borderColor: const Color(0xFFE2E6E4),
          borderWidth: 1.0,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
          handleControllers: (controllers) {
            controller.otpControllers = controllers;
          },
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) {
            controller.otpValue.value = verificationCode;
            controller.verifyOtp(context);
          },
        ),
        const SizedBox(height: 20),

        // Expiration label
        Text(
          controller.expirationText(controller.secondsRemaining),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorConstant.greyColor,
          ),
        ),
        const SizedBox(height: 32),

        // Verify button
        CommonButton(
          height: 55,
          buttonText: 'Verify & Continue',
          fontWeight: FontWeight.bold,
          borderRadius: 20,
          onTap: () {
            final otp = controller.otpControllers
                .map((c) => c?.text ?? '')
                .join()
                .trim();
            if (otp.length < 6) {
              showToastMessage(
                titleMessage: 'Error',
                message: 'Please enter a 6-digit OTP code',
                context: context,
                isError: true,
              );
            } else {
              // context.push(RouteConstant.tellUsAboutYourself);
              controller.onTapVerifyOtp(context);
            }
          },
        ),
        const SizedBox(height: 24),
        if (controller.secondsRemaining == 0)
          // Didn't receive code label
          const Text(
            "Didn't receive the code?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor,
            ),
          ),
        if (controller.secondsRemaining == 0) const SizedBox(height: 12),

        // Resend row button
        if (controller.secondsRemaining == 0)
          InkWell(
            onTap: () {
              controller.reSendOtp(context);
            },
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
                    'Resend',
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
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Check your spam/junk folder if you don\'t see the email.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor,
            ),
          ),
        ),
      ],
    );
  }
}
