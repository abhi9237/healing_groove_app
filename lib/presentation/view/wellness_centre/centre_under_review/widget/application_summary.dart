import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ApplicationSummary extends StatelessWidget {
  final String centerName;
  final String? status;
  final String? createdAt;

  const ApplicationSummary({
    super.key,
    required this.centerName,
    this.status,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final String displayCenterName = centerName.trim().isEmpty ? '' : centerName.trim();
    
    String submissionDate = '';
    if (createdAt != null && createdAt!.isNotEmpty) {
      try {
        final parsedDate = DateTime.parse(createdAt!);
        submissionDate = DateFormat('M/d/yyyy').format(parsedDate);
      } catch (_) {
        submissionDate = createdAt!;
      }
    } else {
      submissionDate = DateFormat('M/d/yyyy').format(DateTime.now());
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Label
          const Text(
            'APPLICATION SUMMARY',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B), // Slate/grey color
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 18),

          // Center Name & Submission Date Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Center Name',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      displayCenterName,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submission Date',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      submissionDate,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Current Status Section
          Text(
            'Current Status',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 8),

          // Dynamic Status Pill
          () {
            final String displayStatus = status ?? 'pending';
            Color statusColor;
            Color statusBgColor;
            String statusText;

            switch (displayStatus.toLowerCase()) {
              case 'approved':
              case 'active':
                statusColor = const Color(0xFF10B981); // Green
                statusBgColor = const Color(0xFFECFDF5);
                statusText = 'Approved';
                break;
              case 'rejected':
              case 'inactive':
                statusColor = const Color(0xFFEF4444); // Red
                statusBgColor = const Color(0xFFFEF2F2);
                statusText = 'Rejected';
                break;
              case 'pending':
              default:
                statusColor = ColorConstant.orangeColor;
                statusBgColor = const Color(0xFFFFF7ED);
                statusText = 'Pending Review';
                break;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Small dot
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            );
          }(),
        ],
      ),
    );
  }
}
