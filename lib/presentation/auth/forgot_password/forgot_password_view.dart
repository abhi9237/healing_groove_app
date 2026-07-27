import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import '../../../controller/forgot_password_controller.dart';
import 'widget/forgot_password_top_widget.dart';
import 'widget/forgot_password_body_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isLoading,
            child: CommonAppBackground(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ForgotPasswordTopWidget(stepIndex: controller.stepIndex),
                    ForgotPasswordBodyWidget(controller: controller),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
