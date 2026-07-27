import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';

import '../../../../common/common_text_form_filled.dart';
import '../../../../controller/login_controller.dart';
import 'login_remenberMe_widget.dart';

class LoginBodyWidget extends StatelessWidget {
  final LoginController controller;
  const LoginBodyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
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
          CommonTextFormFilled(
            controller: controller.emailController.value,
            hintText: 'Email Address',
            prefixIcon: ImageConstant.emailIcon,
          ),
          CommonTextFormFilled(
            controller: controller.passwordController.value,
            hintText: 'Enter Password',
            prefixIcon: ImageConstant.lockIcon,
            suffixIcon: controller.isShowPassword.value
                ? ImageConstant.passwordHideIcon
                : ImageConstant.passwordUnHideIcon,
            obscureText: controller.isShowPassword.value,
            onTapSuffixIcon: controller.onTapHidePassword,
          ),
          RememberMeWidget(
            value: controller.isSelectedRememberMe.value,
            onChanged: (v) => controller.onTapRememberMe(),
            onForgotPassword: () {
              context.push(RouteConstant.forgotPassword);
            },
          ),
          CommonButton(
            height: 60,
            buttonText: 'Sign In',
            fontWeight: FontWeight.bold,
            borderRadius: 20,
            onTap: () => controller.onTapSignIn(context),
          ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account?",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.lightBlackColor,
                    fontFamily: 'Afacad',
                  ),
                ),
                TextSpan(
                  text: '\nSign Up',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                    fontFamily: 'Afacad',
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.onTapSignUp(context);
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
