import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/common/common_button.dart';
import '../../../common/account_progress_bar.dart';
import '../../../controller/create_account_controller.dart';
import '../../../core/route/route_constant/route_constant.dart';
import 'widget/tell_us_about_yourself_form.dart';
import 'widget/tell_us_about_yourself_header.dart';

class TellUsAboutYourselfView extends StatelessWidget {
  const TellUsAboutYourselfView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
      builder: (controller) {
        return Scaffold(
          body: CommonAppBackground(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const AccountProgressBar(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const TellUsAboutYourselfHeader(),
                        const SizedBox(height: 28),
                         TellUsAboutYourselfForm(
                          controller: controller
                         ),
                        const SizedBox(height: 36),
                        CommonButton(
                          height: 60,
                          buttonText: 'Continue',
                          fontWeight: FontWeight.bold,
                          borderRadius: 20,
                          onTap: () {
                            context.push(RouteConstant.selectPreference);
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
