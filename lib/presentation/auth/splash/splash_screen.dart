import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/controller/usercontroller/splash_controller.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/core/image_constant/image_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(context: context),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorConstant.darkGreenColor,
                  ColorConstant.lightBlackColor,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Glowing background circle in the center
                Center(
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorConstant.appColor.withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.appColor.withValues(
                                  alpha: 0.1,
                                ),
                                border: Border.all(
                                  color: ColorConstant.appColor.withValues(
                                    alpha: 0.5,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.splashImg,
                                height: 180,
                                width: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'The Healing Groove',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.whiteColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Botanical vitality for modern life',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.whiteColor.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bottom caption
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Text(
                          'YOUR JOURNEY TO HARMONY BEGINS HERE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.whiteColor.withValues(
                              alpha: 0.6,
                            ),
                            letterSpacing: 2.0,
                          ),
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
