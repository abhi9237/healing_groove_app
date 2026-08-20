import 'package:flutter/material.dart';
import '../../guest/widget/guest_stats_card.dart';

class DoctorStatsGrid extends StatelessWidget {
  final int totalCount;
  final int approvedCount;
  final int pendingCount;
  final String avgExperience;

  const DoctorStatsGrid({
    super.key,
    required this.totalCount,
    required this.approvedCount,
    required this.pendingCount,
    required this.avgExperience,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GuestStatsCard(
                icon: Icons.group_outlined,
                iconColor: const Color(0xFF007A48),
                iconBgColor: const Color(0xFFE8F5E9),
                label: 'Total Doctors',
                value: '$totalCount',
                subtitle: 'Registered',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GuestStatsCard(
                icon: Icons.check_circle_outline_rounded,
                iconColor: const Color(0xFF0D9488),
                iconBgColor: const Color(0xFFF0FDFA),
                label: 'Approved',
                value: '$approvedCount',
                subtitle: 'Verified listings',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GuestStatsCard(
                icon: Icons.access_time_rounded,
                iconColor: const Color(0xFFEA580C),
                iconBgColor: const Color(0xFFFFF7ED),
                label: 'Pending',
                value: '$pendingCount',
                subtitle: 'Awaiting verification',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GuestStatsCard(
                icon: Icons.badge_outlined,
                iconColor: const Color(0xFF4F46E5),
                iconBgColor: const Color(0xFFEEF2FF),
                label: 'Avg Experience',
                value: avgExperience,
                subtitle: 'Years on average',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
