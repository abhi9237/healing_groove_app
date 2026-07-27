import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/auth/welcome/widget/welcome_background_widget.dart';
import 'package:healing/presentation/auth/welcome/widget/welcome_body_widget.dart';
import 'package:healing/presentation/auth/welcome/widget/welcome_gradient_widget.dart';

import '../../../controller/onBoarding_controller.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (controller) {
          return Stack(
            children: [
              WelcomeBackgroundWidget(),
              WelcomeGradientWidget(),
              WelcomeBodyWidget(
                controller: controller,
              ),
            ],
          );
        },
      ),
    );
  }
}
