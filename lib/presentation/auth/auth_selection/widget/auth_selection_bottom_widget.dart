import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import '../../../../common/common_button.dart';
import '../../../../controller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';


class AuthSelectionBottomWidget extends StatelessWidget {
  final CreateAccountController controller;
  const AuthSelectionBottomWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonButton(
          height: 60,
          buttonText: 'Continue',
          fontWeight: FontWeight.bold,
          borderRadius: 20,
          onTap: () =>
              controller.onTapContinue(controller.selectedType.value, context),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.greyColor,
                  fontFamily: 'Afacad',
                ),
              ),
              TextSpan(
                text: 'Sign in',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                  fontFamily: 'Afacad',
                ),
                recognizer:  TapGestureRecognizer()
                  ..onTap = () {
                    controller.onTapAuthSelectionSignIn(context);
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
