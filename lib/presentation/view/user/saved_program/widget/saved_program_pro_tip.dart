import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class SavedProgramProTip extends StatelessWidget {
  const SavedProgramProTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F4), // Light green-grey tint background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Icon Container
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFECFDF3), // Mint green circle
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.star_rounded,
                color: ColorConstant.appColor,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Message details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pro tip',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Save centres to easily compare options and return visits. You can create packages from saved centres for faster booking.',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.greyColor.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
