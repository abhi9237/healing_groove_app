import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class AdminControlBanner extends StatelessWidget {
  const AdminControlBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shield Icon Container
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9), // Light green background
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.gpp_good_outlined,
              color: ColorConstant.appColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Message Column
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Admin Quality Control",
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Programs enter a curated review state before becoming live for guests.",
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 13,
                    color: Color(0xFF414943),
                    height: 1.35,
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
