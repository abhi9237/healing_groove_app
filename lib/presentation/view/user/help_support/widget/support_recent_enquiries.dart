import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class SupportRecentEnquiries extends StatelessWidget {
  const SupportRecentEnquiries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Enquiries',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                Text(
                  '0 Enquiries',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.greyColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(
            color: Colors.grey.shade200,
            thickness: 1,
            height: 1,
          ),

          // Body Content (Empty state)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular Chat Icon Container
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F6FB), // Light grey/blue background
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.forum_outlined,
                        color: Color(0xFF667085),
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'No active enquiries',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    'When you submit a request, it will appear here so you can track its progress.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.greyColor.withValues(alpha: 0.8),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
