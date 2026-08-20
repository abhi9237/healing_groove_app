import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ReportInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const ReportInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(color: Color(0xFFF1F5F9), height: 1),
      ],
    );
  }
}
