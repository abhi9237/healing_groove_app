import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/edit_profile_controller.dart';

import '../../../../../core/image_constant/image_constant.dart';

class EditSecurityCard extends StatelessWidget {
  final EditProfileController controller;

  const EditSecurityCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      padding: const EdgeInsets.all(15.0),
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
                      'Security',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Manage your access and protection',
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
          const SizedBox(height: 20),

          // Obscured Password Field with Toggle Eye Icon
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 14),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: Colors.grey.shade300, width: 1),
          //   ),
          //   child: Row(
          //     children: [
          //
          //       // Expanded(
          //       //   child: TextField(
          //       //     controller: controller.passwordController,
          //       //     obscureText: controller.obscurePassword,
          //       //     readOnly: true,
          //       //     style: const TextStyle(
          //       //       fontSize: 16,
          //       //       fontWeight: FontWeight.w600,
          //       //       color: ColorConstant.lightBlackColor,
          //       //       letterSpacing: 2.0,
          //       //     ),
          //       //     decoration: const InputDecoration(
          //       //       border: InputBorder.none,
          //       //       contentPadding: EdgeInsets.symmetric(vertical: 12),
          //       //     ),
          //       //   ),
          //       // ),
          //       IconButton(
          //         icon: Icon(
          //           controller.obscurePassword
          //               ? Icons.visibility_outlined
          //               : Icons.visibility_off_outlined,
          //           color: Colors.grey.shade500,
          //           size: 20,
          //         ),
          //         onPressed: controller.togglePasswordVisibility,
          //       ),
          //     ],
          //   ),
          // ),
          // CommonTextFormFilled(
          //   hintText: 'Enter old password',
          //   controller: controller.passwordController,
          //   obscureText: controller.obscurePassword,
          //   suffixIcon: ImageConstant.passwordHideIcon,
          // ),
          // const SizedBox(height: 12),

          // Change Password Row Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.onTapChangePassword(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Change Password',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey.shade400,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // MFA Info Alert Box (Light Purple)
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF), // Light purple tint
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.gpp_good_rounded,
                  color: Color(0xFF7F56D9), // Purple shield check icon
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Multi-factor authentication is active for your account security.',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF344054).withValues(alpha: 0.85),
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
