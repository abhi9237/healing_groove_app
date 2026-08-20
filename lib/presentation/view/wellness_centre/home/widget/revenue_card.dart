import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class RevenueCard extends StatelessWidget {
  final String revenue;
  const RevenueCard({super.key, required this.revenue});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Revenue",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            revenue,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: ColorConstant.appColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Confirmed bookings",
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
