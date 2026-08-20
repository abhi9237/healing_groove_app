import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_button.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/controller/usercontroller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<ChangePasswordController>(
          init: ChangePasswordController(),
          builder: (controller) {
            return AppLoader(
              isLoading: controller.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonAppBar(title: 'Change Password'),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFECFDF3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      color: ColorConstant.appColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Update Password',
                                        style: TextStyle(
                                          fontFamily: 'Afacad',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstant.lightBlackColor,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Set a strong password to secure your account access',
                                        style: TextStyle(
                                          fontFamily: 'Afacad',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstant.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Old Password
                            const Text(
                              'Old Password',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.greyColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CommonTextFormFilled(
                              controller: controller.oldPasswordController,
                              hintText: 'Enter old password',
                              prefixIcon: ImageConstant.lockIcon,
                              suffixIcon: controller.obscureOldPassword
                                  ? ImageConstant.passwordHideIcon
                                  : ImageConstant.passwordUnHideIcon,
                              obscureText: controller.obscureOldPassword,
                              onTapSuffixIcon: controller.toggleOldPasswordObscure,
                            ),
                            const SizedBox(height: 16),

                            // New Password
                            const Text(
                              'New Password',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.greyColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CommonTextFormFilled(
                              controller: controller.newPasswordController,
                              hintText: 'Enter new password',
                              prefixIcon: ImageConstant.lockIcon,
                              suffixIcon: controller.obscureNewPassword
                                  ? ImageConstant.passwordHideIcon
                                  : ImageConstant.passwordUnHideIcon,
                              obscureText: controller.obscureNewPassword,
                              onTapSuffixIcon: controller.toggleNewPasswordObscure,
                            ),
                            const SizedBox(height: 16),

                            // Confirm New Password
                            const Text(
                              'Confirm New Password',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.greyColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CommonTextFormFilled(
                              controller: controller.confirmPasswordController,
                              hintText: 'Confirm new password',
                              prefixIcon: ImageConstant.lockIcon,
                              suffixIcon: controller.obscureConfirmPassword
                                  ? ImageConstant.passwordHideIcon
                                  : ImageConstant.passwordUnHideIcon,
                              obscureText: controller.obscureConfirmPassword,
                              onTapSuffixIcon: controller.toggleConfirmPasswordObscure,
                            ),
                            const SizedBox(height: 30),

                            // Submit button (CommonButton)
                            CommonButton(
                              buttonText: 'Change Password',
                              fontWeight: FontWeight.bold,
                              borderRadius: 14,
                              height: 50,
                              onTap: () => controller.changePassword(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
