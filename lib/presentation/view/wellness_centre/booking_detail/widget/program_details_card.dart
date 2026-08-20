import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../presentation/model/common/doc_model.dart';

class ProgramDetailsCard extends StatelessWidget {
  final DocModel booking;

  const ProgramDetailsCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final String program = booking.package?.name ?? '';
    final String duration = '${booking.package?.duration ?? 0} days';
    
    String checkIn = '—';
    String checkOut = '—';
    if (booking.startDate != null) {
      try {
        final start = DateTime.parse(booking.startDate!).toLocal();
        final durationVal = booking.package?.duration ?? 1;
        final end = start.add(Duration(days: durationVal - 1));
        checkIn = "${start.month}/${start.day}/${start.year}";
        checkOut = "${end.month}/${end.day}/${end.year}";
      } catch (_) {
        checkIn = booking.startDate!;
      }
    }

    final String consultation = booking.hasConsultation == true ? 'Scheduled' : 'Not Scheduled';
    final String slotTime = booking.slotTime?.toString() ?? '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PROGRAM DETAILS",
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1 (Left Items)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                      icon: Icons.spa_outlined,
                      label: "PROGRAM",
                      value: program,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem(
                      icon: Icons.calendar_today_outlined,
                      label: "CHECK-IN",
                      value: checkIn,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem(
                      icon: Icons.medical_services_outlined,
                      label: "CONSULTATION",
                      value: consultation,
                      valueColor: consultation.toLowerCase().contains('not')
                          ? Colors.grey.shade500
                          : ColorConstant.lightBlackColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Column 2 (Right Items)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                      icon: Icons.access_time_rounded,
                      label: "DURATION",
                      value: duration,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem(
                      icon: Icons.calendar_today_outlined,
                      label: "CHECK-OUT",
                      value: checkOut,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem(
                      icon: Icons.watch_later_outlined,
                      label: "SLOT TIME",
                      value: slotTime,
                      valueColor: slotTime == '—'
                          ? Colors.grey.shade500
                          : ColorConstant.lightBlackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey.shade400,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
