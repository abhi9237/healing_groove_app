import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ServiceActiveToggle extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const ServiceActiveToggle({
    super.key,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Label details
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Available for package selection",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 12.5,
                  color: Color(0xFF414943),
                ),
              ),
            ],
          ),

          // Right: Switch toggle
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeThumbColor: Colors.white,
            activeTrackColor: ColorConstant.appColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
