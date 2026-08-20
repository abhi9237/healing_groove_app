import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/presentation/auth/create_account/widget/already_have_account_widget.dart';
import '../../../common/account_progress_bar.dart';
import '../../../common/app_loader.dart';
import '../../../controller/usercontroller/create_account_controller.dart';
import 'widget/create_account_form.dart';
import 'widget/create_account_header.dart';

class CreateAccountView extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const CreateAccountView({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateAccountController>(
        init: CreateAccountController(
          arguments: arguments
        ),
        builder: (controller) {
          return AppLoader(
            isLoading: controller.isLoadingCreateAccount,
            child: CommonAppBackground(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: AccountProgressBar(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          const CreateAccountHeader(),
                          const SizedBox(height: 24),
                          CreateAccountForm(controller: controller),
                          const SizedBox(height: 24),
                           AlreadyHaveAccountWidget(
                             controller: controller,
                           ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
