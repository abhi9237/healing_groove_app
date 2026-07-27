import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../../../../controller/onBoarding_controller.dart';
import '../../../../core/color_constant/color_constant.dart';

class WelcomeBodyWidget extends StatelessWidget {
  final OnboardingController controller;
  const WelcomeBodyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: 0,
      bottom: 0,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.appLogo,
            height: 100,
            width: 100,
          ),
          SizedBox(height: 10),
          Text(
            'Welcome to The Healing Groove',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: ColorConstant.whiteColor,
              height: 1.0,
            ),
          ),
          Text(
            'Book Authentic Ayurvedic Wellness\n Across India',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorConstant.whiteColor,
            ),
          ),

          CommonButton(
            buttonText: 'Create an Account',
            bgColor: ColorConstant.whiteColor,
            textColor: ColorConstant.appColor,
            fontWeight: FontWeight.bold,
            onTap: () => controller.onTapCreateAccount(context),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorConstant.whiteColor,
                fontFamily: 'Afacad',
              ),
              children: [
                const TextSpan(text: 'Already have an account?'),
                TextSpan(
                  text: ' Sign in',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  recognizer:  TapGestureRecognizer()
                    ..onTap = () {
                     controller.onTapSignIn(context);
                    },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
