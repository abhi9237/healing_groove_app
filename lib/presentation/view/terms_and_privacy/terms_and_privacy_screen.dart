import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healing/common/common_app_bar.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/terms_and_privacy_controller.dart';

class TermsAndPrivacyScreen extends StatefulWidget {
  final bool isTerms;
  const TermsAndPrivacyScreen({super.key, this.isTerms = true});

  @override
  State<TermsAndPrivacyScreen> createState() => _TermsAndPrivacyScreenState();
}

class _TermsAndPrivacyScreenState extends State<TermsAndPrivacyScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(TermsAndPrivacyController(), tag: widget.isTerms.toString());
    controller.fetchTermsAndPrivacy(widget.isTerms);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isTerms ? 'Terms and Conditions' : 'Privacy Policy';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: SafeArea(
        child: Column(
          children: [
            CommonAppBar(title: title, showBackButton: true),
            Expanded(
              child: GetBuilder<TermsAndPrivacyController>(
                tag: widget.isTerms.toString(),
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.appColor),
                      ),
                    );
                  }

                  final data = controller.data;
                  if (data == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load $title',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title ?? title,
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.lightBlackColor,
                          ),
                        ),
                        if (data.lastUpdated != null || data.updatedAt != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Last updated: ${data.lastUpdated ?? data.updatedAt}',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFFE2E8F0), thickness: 1.2),
                        const SizedBox(height: 20),
                        Html(
                          data: data.content ?? 'No content available.',
                          style: {
                            "body": Style(
                              fontFamily: 'Afacad',
                              fontSize: FontSize(15),
                              lineHeight: LineHeight(1.6),
                              color: ColorConstant.lightBlackColor,
                              margin: Margins.zero,
                            ),
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
