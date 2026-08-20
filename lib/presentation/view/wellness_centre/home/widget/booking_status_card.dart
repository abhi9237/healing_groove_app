import 'package:flutter/material.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BookingStatusCard extends StatelessWidget {
  final List<DocModel> statusData;
  const BookingStatusCard({super.key, required this.statusData});

  @override
  Widget build(BuildContext context) {
    final confirmedCount = statusData.where((b) => (b.status ?? '').toLowerCase() == 'confirmed').length;
    final inProgressCount = statusData.where((b) {
      final status = (b.status ?? '').toLowerCase();
      return status == 'in_progress' || status == 'in progress';
    }).length;
    final pendingCount = statusData.where((b) {
      final status = (b.status ?? '').toLowerCase();
      return status == 'pending' ||
          status == 'requested' ||
          status == 'awaiting confirmation' ||
          status ==  'initiated'||
          status == 'awaiting_confirmation';
    }).length;
    final completedCount = statusData.where((b) => (b.status ?? '').toLowerCase() == 'completed').length;
    final cancelledCount = statusData.where((b) {
      final status = (b.status ?? '').toLowerCase();
      return status == 'cancelled' || status == 'canceled' || status == 'rejected';
    }).length;

    final distribution = [
      {
        'status': 'Confirmed',
        'count': confirmedCount,
      },
      {
        'status': 'In Progress',
        'count': inProgressCount,
      },
      {
        'status': 'Pending',
        'count': pendingCount,
      },
      {
        'status': 'Completed',
        'count': completedCount,
      },
      {
        'status': 'Cancelled',
        'count': cancelledCount,
      },
    ];

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
            "Booking Status",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Current distribution",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: distribution.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFF1F5F9),
              height: 20,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final item = distribution[index];
              final String status = item['status'] as String;
              final int count = item['count'] as int;

              IconData icon;
              Color iconColor;

              switch (status) {
                case 'Confirmed':
                  icon = Icons.check_circle_rounded;
                  iconColor = const Color(0xFF08864F);
                  break;
                case 'In Progress':
                  icon = Icons.trending_up_rounded;
                  iconColor = const Color(0xFF64748B);
                  break;
                case 'Pending':
                  icon = Icons.pending_outlined;
                  iconColor = const Color(0xFF64748B);
                  break;
                case 'Completed':
                  icon = Icons.done_all_rounded;
                  iconColor = const Color(0xFF64748B);
                  break;
                case 'Cancelled':
                  icon = Icons.cancel_outlined;
                  iconColor = const Color(0xFFEF4444);
                  break;
                default:
                  icon = Icons.info_outline_rounded;
                  iconColor = Colors.grey;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: iconColor, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        status,
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$count",
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
