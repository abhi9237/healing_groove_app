import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/auth/onBoarding/widget/onBoarding_body_widget.dart';
import '../../../common/common_auth_background.dart';
import '../../../controller/onBoarding_controller.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppBackground(
        child: GetBuilder<OnboardingController>(
          init: OnboardingController(context: context),
          builder: (controller) {
            return OnboardingBodyWidget(controller: controller);
          },
        ),
      ),
    );
  }
}
