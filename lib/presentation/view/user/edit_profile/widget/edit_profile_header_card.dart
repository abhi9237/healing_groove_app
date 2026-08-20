import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/edit_profile_controller.dart';

class EditProfileHeaderCard extends StatelessWidget {
  final EditProfileController controller;
  const EditProfileHeaderCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      height: 250,
      decoration: BoxDecoration(
        gradient: CommonGradientColor.packageBackgroundGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.appColor.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Decorative background circle 1
            Positioned(
              left: -40,
              top: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Decorative background circle 2
            Positioned(
              right: -50,
              bottom: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Center details
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar with edit button overlay
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 44,
                          backgroundImage: NetworkImage(
                            'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
                          ),
                        ),
                      ),
                      // Positioned(
                      //   right: 2,
                      //   bottom: 2,
                      //   child: Container(
                      //     width: 26,
                      //     height: 26,
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFF0C5C36), // Deep green
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         color: Colors.white,
                      //         width: 1.5,
                      //       ),
                      //     ),
                      //     child: const Center(
                      //       child: Icon(
                      //         Icons.edit_rounded,
                      //         color: Colors.white,
                      //         size: 13,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Name
                  Text(
                    controller.nameController.text,
                    style: const TextStyle(

                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Email
                  Text(
                    controller.emailController.value.text,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // User tag badge (translucent white container, green dot, white text)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981), // Emerald green dot
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                         Text(
                         controller.role ,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
