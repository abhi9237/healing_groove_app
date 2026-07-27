import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/presentation/auth/auth_selection/widget/auth_selection_bottom_widget.dart';
import '../../../controller/create_account_controller.dart';
import 'widget/auth_option_card.dart';
import 'widget/auth_selection_header.dart';

class AuthSelectionView extends StatelessWidget {
  const AuthSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateAccountController>(
        init: CreateAccountController(),
        builder: (controller) {
          return CommonAppBackground(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const AuthSelectionHeader(),
                  const SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.userSelectionList.length,
                    itemBuilder: (context, index) {
                      final item = controller.userSelectionList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AuthOptionCard(
                          userSelectionType: item,
                          isSelected:
                              item.type == controller.selectedType.value,
                          onTap: () => controller.onTapSelectType(item.type),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 36),
                  AuthSelectionBottomWidget(controller: controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
