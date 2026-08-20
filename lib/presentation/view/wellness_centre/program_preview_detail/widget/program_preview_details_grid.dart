import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ProgramPreviewDetailsGrid extends StatelessWidget {
  final DocModel program;
  const ProgramPreviewDetailsGrid({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final String durationVal = program.durationText ?? (program.duration != null ? '${program.duration} days' : '1 day');
    final String minGuestsVal = program.minGuests?.toString() ?? '1';
    final String maxGuestsVal = program.maxGuests?.toString() ?? '10';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: ColorConstant.appColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Program Details',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Grid Rows
        Row(
          children: [
            // Category Card
            Expanded(
              child: _buildDetailCard(
                icon: Icons.spa_outlined,
                iconBgColor: const Color(0xFFE8F5E9), // light green
                iconColor: ColorConstant.appColor,
                label: 'Category',
                value: 'Wellness',
              ),
            ),
            const SizedBox(width: 12),
            // Duration Card
            Expanded(
              child: _buildDetailCard(
                icon: Icons.access_time_rounded,
                iconBgColor: const Color(0xFFEFF6FF), // light blue
                iconColor: const Color(0xFF1D4ED8),
                label: 'Duration',
                value: durationVal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Min Guests Card
            Expanded(
              child: _buildDetailCard(
                icon: Icons.person_add_alt_1_rounded,
                iconBgColor: const Color(0xFFFFF7ED), // light orange
                iconColor: const Color(0xFFC2410C),
                label: 'Min Guests',
                value: minGuestsVal,
              ),
            ),
            const SizedBox(width: 12),
            // Max Guests Card
            Expanded(
              child: _buildDetailCard(
                icon: Icons.people_outline_rounded,
                iconBgColor: const Color(0xFFF1F5F9), // light grey
                iconColor: Colors.grey.shade700,
                label: 'Max Guests',
                value: maxGuestsVal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon box
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),
          const SizedBox(height: 14),
          // Label
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 4),
          // Value
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
