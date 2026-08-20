import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BookingSummaryCards extends StatelessWidget {
  final List<Map<String, dynamic>> metrics;
  const BookingSummaryCards({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(metrics.length, (index) {
        final item = metrics[index];
        final String label = item['label'] as String;
        final int count = item['count'] as int;
        final IconData icon = item['icon'] as IconData;
        final Color color = item['color'] as Color;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == metrics.length - 1 ? 0 : 8,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
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
                      color: color,
                      size: 22,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "$count",
                  style: const TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
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
