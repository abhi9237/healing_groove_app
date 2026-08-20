import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class SupportStatsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SupportStatsTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: ColorConstant.appColor,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
