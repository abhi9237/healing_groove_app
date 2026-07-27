import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/common/common_auth_background.dart';
import 'package:healing/controller/help_support_controller.dart';
import 'widget/support_header.dart';
import 'widget/support_chips.dart';
import 'widget/support_request_card.dart';
import 'widget/support_recent_enquiries.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: CommonAppBackground(
        child: GetBuilder<HelpSupportController>(
          init: HelpSupportController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar matching other details pages
                const CommonAppBar(title: 'Help & Support'),

                // Scrollable main content details
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title description
                        const SupportHeader(),

                        // Category choice horizontal chips
                        SupportChips(controller: controller),
                        const SizedBox(height: 8),

                        // Form submit card
                        SupportRequestCard(controller: controller),
                        const SizedBox(height: 12),

                        // Recent Enquiries status box
                        const SupportRecentEnquiries(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
