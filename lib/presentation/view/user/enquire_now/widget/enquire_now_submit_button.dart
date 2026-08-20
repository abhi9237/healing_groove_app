import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_widget.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/enquire_now_controller.dart';

class EnquireNowSubmitButton extends StatelessWidget {
  final EnquireNowController controller;

  const EnquireNowSubmitButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          // Submit Button or Loader
          Obx(
            () => controller.isLoading.value
                ? const SizedBox(
                    height: 54,
                    child: CommonCircularIndicator(),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () => controller.submitEnquiry(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.appColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Submit Enquiry',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          
          // Disclaimer Footer
          Text(
            'Our wellness consultants usually respond\nwithin 24 hours.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.6),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
