import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import '../../../common/account_progress_bar.dart';
import '../../../controller/create_account_controller.dart';
import 'widget/verify_otp_form.dart';
import 'widget/verify_otp_header.dart';

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateAccountController>(
        init: CreateAccountController(),
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isLoadingVerifyOtp,
            child: CommonAppBackground(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const AccountProgressBar(),
                    const SizedBox(height: 30),
                    VerifyOtpHeader(
                      email: controller.emailController.value.text,
                    ),
                    const SizedBox(height: 36),
                    VerifyOtpForm(controller: controller),
                    const SizedBox(height: 10),
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
