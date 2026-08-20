import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ProgramPreviewHeader extends StatelessWidget {
  final DocModel program;
  const ProgramPreviewHeader({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final String rawStatus = (program.approvalStatus ?? program.status ?? 'draft').toLowerCase();
    
    // Status color and label mapping
    final String statusLabel;
    final Color statusBgColor;
    final Color statusTextColor;

    if (rawStatus == 'pending_approval' || rawStatus == 'pending') {
      statusLabel = 'PENDING APPROVAL';
      statusBgColor = const Color(0xFFFFF7ED); // Light orange
      statusTextColor = const Color(0xFFC2410C); // Dark orange
    } else if (rawStatus == 'live') {
      statusLabel = 'LIVE';
      statusBgColor = const Color(0xFFE8F5E9); // Light green
      statusTextColor = ColorConstant.appColor;
    } else {
      statusLabel = 'DRAFT';
      statusBgColor = const Color(0xFFF1F5F9); // Light grey
      statusTextColor = Colors.grey.shade600;
    }

    // Format updated date (e.g., "Modified: 5/20/2026")
    String modifiedDate = 'Modified: —';
    if (program.updatedAt != null) {
      try {
        final parsedDate = DateTime.parse(program.updatedAt!);
        modifiedDate = 'Modified: ${parsedDate.month}/${parsedDate.day}/${parsedDate.year}';
      } catch (_) {}
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Pill & Modified Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusLabel,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: statusTextColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Text(
              modifiedDate,
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Program Name
        Text(
          program.name ?? program.title ?? '',
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
          ),
        ),
        const SizedBox(height: 12),

        // Bookings count pill (with custom styling matching the mockup)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // very light blue
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.people_outline_rounded,
                size: 15,
                color: Color(0xFF1D4ED8),
              ),
              SizedBox(width: 6),
              Text(
                '0 Bookings',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Description Card Box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "DESCRIPTION" label row
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: ColorConstant.appColor.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'DESCRIPTION',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor.withValues(alpha: 0.8),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Description content text
              Text(
                program.description ?? 'No description provided.',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
