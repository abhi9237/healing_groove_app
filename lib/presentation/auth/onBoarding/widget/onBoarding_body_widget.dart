import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../../../../common/common_button.dart';
import '../../../../controller/onBoarding_controller.dart';
import '../../../../core/color_constant/color_constant.dart';

class OnboardingBodyWidget extends StatelessWidget {
  final OnboardingController controller;
  const OnboardingBodyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
            physics:const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (int page) {
                controller.currentPage.value = page;
              },
              itemCount: controller.pages.length,
              itemBuilder: (context, index) {
                final page = controller.pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.78,
                      child: CustomImageView(imagePath: page.imagePath),
                    ),

                    const SizedBox(height: 48),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        page.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: ColorConstant.appColor,
                          height: 1.25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Text(
                        page.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorConstant.greyColor,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Indicators and Navigation Button
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 6,
                        width: controller.currentPage.value == index ? 22 : 6,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? ColorConstant.appColor
                              : const Color(0xFFCFD8D3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Primary action button
                  CommonButton(
                    height: 65,
                    buttonText: controller
                        .pages[controller.currentPage.value]
                        .buttonText,

                    onTap:()=> controller.onTap(context,controller.currentPage.value+1),
                    nextImg: ImageConstant.nextArrowIcon,
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
