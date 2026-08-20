import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/settings_controller.dart';
import 'package:healing/core/storage/hive_storage_service.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        final name = HiveStorageService.getUserName() ?? '';
        final email = HiveStorageService.getUserEmail() ?? '';

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          height: 240,
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

                // Profile info centered
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Photo with Edit overlay
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorConstant.whiteColor,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                             ( name != null && name.isNotEmpty) ? (name ?? '').substring(0, 1) : '',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.whiteColor,
                              ),
                            ),
                            // const CircleAvatar(
                            //   radius: 18,
                            //   backgroundColor: ColorConstant.lightGreenColor,
                            //   backgroundImage: NetworkImage(
                            //     'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
                            //   ),
                            // ),
                          ),

                          // Container(
                          //   padding: const EdgeInsets.all(3.0),
                          //   decoration: const BoxDecoration(
                          //     color: Colors.white,
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: const CircleAvatar(
                          //     radius: 46,
                          //     backgroundImage: NetworkImage(
                          //       'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            right: 2,
                            bottom: 10,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0C5C36), // Deep green
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Name
                      Text(
                        name ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Email
                      Text(
                        email ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
