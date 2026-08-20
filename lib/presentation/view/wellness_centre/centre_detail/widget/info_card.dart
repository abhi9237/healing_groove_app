import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7ED), // Light green tint
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: ColorConstant.appColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your center profile will be used to match you with seekers looking for specific wellness journeys. Accurate details ensure better engagement.',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14,
                height: 1.4,
                color: ColorConstant.lightBlackColor.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
