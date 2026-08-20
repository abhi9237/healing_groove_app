import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import '../../../../../../../presentation/model/common/doc_model.dart';

class GuestCard extends StatelessWidget {
  final DocModel booking;
  final int bookingsCount;
  final double totalSpend;
  final String lastBookingDate;
  final bool isReturning;
  final VoidCallback onViewDetails;

  const GuestCard({
    super.key,
    required this.booking,
    required this.bookingsCount,
    required this.totalSpend,
    required this.lastBookingDate,
    required this.isReturning,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final String name = booking.user?.name ??
        (booking.guests != null && booking.guests!.isNotEmpty
            ? booking.guests![0].fullName ?? 'Guest'
            : 'Guest');
    final String email = booking.user?.email ?? booking.email ?? '—';
    final String status = booking.status ?? 'Requested';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Avatar, Name, Email, Eye)
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: ColorConstant.appColor.withValues(alpha: 0.1),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'G',
                  style: const TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onViewDetails,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Statistics details box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.assignment_outlined,
                  label: 'Bookings',
                  value: '$bookingsCount',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Total Spend',
                  value: '₹${totalSpend.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Last Booking',
                  value: lastBookingDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Bottom badges (Requested, Returning)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Requested Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.appColor,
                  ),
                ),
              ),

              // Returning Badge
              if (isReturning)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Returning',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.appColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.cached_rounded,
                        size: 14,
                        color: ColorConstant.appColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // light blue
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1D4ED8),
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const Spacer(),
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
    );
  }
}
