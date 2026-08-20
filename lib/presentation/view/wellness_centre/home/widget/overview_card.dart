import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class OverviewCard extends StatelessWidget {
  final Map<String, dynamic> overviewData;
  const OverviewCard({super.key, required this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          const Text(
            "Overview",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "All time summary",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 20),

          // Total Bookings Row
          _buildMetricRow("Total Bookings", "${overviewData['Total Bookings'] ?? 0}"),
          const SizedBox(height: 16),

          // Active Bookings Row
          _buildMetricRow("Active Bookings", "${overviewData['Active Bookings'] ?? 0}"),
          const SizedBox(height: 16),

          // Completion Rate Row
          _buildMetricRow("Completion Rate", "${overviewData['Completion Rate'] ?? '0%'}"),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(
              color: Color(0xFFF1F5F9),
              thickness: 1,
              height: 1,
            ),
          ),

          // Total Revenue Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Revenue",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              Text(
                "${overviewData['Total Revenue'] ?? '₹0'}",
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14.5,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 24,
              height: 1.5,
              color: const Color(0xFFBCEECF), // Light green underline accent
            ),
          ],
        ),
      ],
    );
  }
}
