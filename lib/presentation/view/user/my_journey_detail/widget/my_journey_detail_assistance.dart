import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/my_journey_detail_controller.dart';

class MyJourneyDetailAssistance extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyDetailAssistance({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Headset circular icon
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE2F7EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.headset_mic_outlined,
                color: ColorConstant.appColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            
            // Text Column
            const Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Our concierges are available 24/7',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorConstant.greyColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            
            // Connect with Us Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => controller.connectWithUs(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.appColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Connect with Us',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
