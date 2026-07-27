import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import '../../../../controller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  final CreateAccountController controller;
  const AlreadyHaveAccountWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RichText(
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.isComingAuthSelection.value
                    ? context.pushReplacement(RouteConstant.login)
                    : context.pop();
              },
          ),
        ],
      ),
    );
  }
}
