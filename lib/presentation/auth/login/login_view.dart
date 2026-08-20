import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/presentation/auth/login/widget/login_body_widget.dart';
import 'package:healing/presentation/auth/login/widget/login_top_widget.dart';
import '../../../controller/usercontroller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
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
                    LoginTopWidget(),
                    LoginBodyWidget(controller: controller),
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
