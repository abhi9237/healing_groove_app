import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/cancel_confirmation_controller.dart';
import 'widget/confirmation_header.dart';
import 'widget/notification_card.dart';
import 'widget/confirmation_buttons.dart';

class CancelConfirmation extends StatelessWidget {
  const CancelConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppBackground(
        child: GetBuilder<CancelConfirmationController>(
          init: CancelConfirmationController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          ConfirmationHeader(),
                          SizedBox(height: 16),
                          NotificationCard(),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  ConfirmationButtons(controller: controller),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
