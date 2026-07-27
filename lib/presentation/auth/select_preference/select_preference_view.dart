import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/app_loader.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/presentation/auth/select_preference/widget/select_preference_bottom_button_widget.dart';
import '../../../common/account_progress_bar.dart';
import '../../../controller/create_account_controller.dart';
import 'widget/select_preference_form.dart';
import 'widget/select_preference_header.dart';

class SelectPreferenceView extends StatelessWidget {
  const SelectPreferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateAccountController>(
        init: CreateAccountController(),
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isLoadingLetsStart,
            child: CommonAppBackground(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15, ),
                child: Column(
                  children: [
                    const AccountProgressBar(),
                    const SizedBox(height: 10),
                    const SelectPreferenceHeader(),
                    const SizedBox(height: 28),
                     SelectPreferenceForm(
                      controller: controller,
                    ),
                    const SizedBox(height: 38),
                    SelectPreferenceBottomButtonWidget(
                      controller: controller,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
