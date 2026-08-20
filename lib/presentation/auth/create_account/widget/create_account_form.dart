import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import '../../../../common/common_button.dart';
import '../../../../common/common_text_form_filled.dart';
import '../../../../controller/usercontroller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';
import '../../../../core/image_constant/image_constant.dart';

class CreateAccountForm extends StatelessWidget {
  final CreateAccountController controller;
  const CreateAccountForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 28),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: ColorConstant.borderLightGreenColor.withValues(alpha: 0.15),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name
          const Text(
            'Full Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 8),
          CommonTextFormFilled(
            controller: controller.fullNameController.value,
            hintText: 'Full Name',
            prefixIcon: ImageConstant.userIcon,
          ),
          const SizedBox(height: 15),

          // Email Address
          const Text(
            'Email Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 8),
          CommonTextFormFilled(
            controller: controller.emailController.value,
            hintText: 'you@example.com',
            prefixIcon: ImageConstant.emailIcon,
          ),
          const SizedBox(height: 15),

          // Password
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 8),
          CommonTextFormFilled(
            onTapSuffixIcon: controller.isShowPasswordToggle,
            controller: controller.passwordController.value,
            hintText: 'Min. 8 characters',
            prefixIcon: ImageConstant.lockIcon,
            suffixIcon: controller.isShowPassword.value
                ? ImageConstant.passwordHideIcon
                : ImageConstant.passwordUnHideIcon,
            obscureText: controller.isShowPassword.value,
          ),
          const SizedBox(height: 15),

          // Confirm Password
          const Text(
            'Confirm Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 8),
          CommonTextFormFilled(
            onTapSuffixIcon: controller.isShowConfirmPasswordToggle,
            controller: controller.confirmPasswordController.value,
            hintText: 'Repeat your password',
            prefixIcon: ImageConstant.lockIcon,
            suffixIcon: controller.isShowConfirmPassword.value
                ? ImageConstant.passwordHideIcon
                : ImageConstant.passwordUnHideIcon,
            obscureText: controller.isShowConfirmPassword.value,
          ),
          const SizedBox(height: 15),

          // Checkbox + Terms & Conditions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: controller.onTapAgreeTermsAndPrivacy,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  child: controller.isAgreeCondition.value
                      ? Center(
                          child: Icon(
                            Icons.done,
                            color: ColorConstant.appColor,
                            size: 15,
                          ),
                        )
                      : SizedBox(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.greyColor,
                      fontFamily: 'Afacad',
                      height: 1.35,
                    ),
                    children: [
                      const TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: ColorConstant.appColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorConstant.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(
                              RouteConstant.termsAndPrivacy,
                              extra: {'isTerms': true},
                            );
                          },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: ColorConstant.appColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorConstant.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(
                              RouteConstant.termsAndPrivacy,
                              extra: {'isTerms': false},
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Button
          CommonButton(
            height: 55,
            buttonText: 'Create Account',
            fontWeight: FontWeight.bold,
            borderRadius: 20,
            onTap: () {
              log('${HiveStorageService.getUserType()}');
              controller.onTapCreateAccount(context);
            },
          ),
        ],
      ),
    );
  }
}
