import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ProgramSummaryCards extends StatelessWidget {
  final List<Map<String, dynamic>> metrics;
  const ProgramSummaryCards({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(metrics.length, (index) {
        final item = metrics[index];
        final String label = item['label'] as String;
        final int count = item['count'] as int;
        final IconData icon = item['icon'] as IconData;

        // Custom styling for each card to match screen mockups
        Color bgColor;
        Color accentColor;
        Color labelColor;

        if (label.contains('ACTIVE')) {
          bgColor = const Color(0xFFE8F5E9); // Light green background
          accentColor = ColorConstant.appColor;
          labelColor = ColorConstant.appColor.withValues(alpha: 0.8);
        } else if (label.contains('REVIEW')) {
          bgColor = const Color(0xFFFFF7ED); // Light orange background
          accentColor = ColorConstant.orangeColor;
          labelColor = ColorConstant.orangeColor.withValues(alpha: 0.8);
        } else {
          bgColor = Colors.white;
          accentColor = ColorConstant.appColor;
          labelColor = Colors.grey.shade500;
        }

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 6,
              right: index == metrics.length - 1 ? 0 : 6,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: label.contains('TOTAL') ? const Color(0xFFE2E8F0) : Colors.transparent,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.01),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      icon,
                      color: accentColor,
                      size: 18,
                    ),
                    Expanded(
                      child: Text(
                        label,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: labelColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  "$count",
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: label.contains('TOTAL') ? ColorConstant.lightBlackColor : accentColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
