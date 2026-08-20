import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class PriceSummary extends StatelessWidget {
  final int programPrice;
  final int selectedServicesCount;
  final int selectedServicesPrice;
  final int totalEstimate;

  const PriceSummary({
    super.key,
    required this.programPrice,
    required this.selectedServicesCount,
    required this.selectedServicesPrice,
    required this.totalEstimate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header with icon
          const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: ColorConstant.appColor,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Price Summary",
                style: TextStyle(
                       
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Program Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Program price",
                style: TextStyle(
                       
                  fontSize: 14.5,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹${_formatNum(programPrice)}",
                style: const TextStyle(
                       
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Selected Services Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selected services ($selectedServicesCount)",
                style: TextStyle(
                       
                  fontSize: 14.5,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹${_formatNum(selectedServicesPrice)}",
                style: const TextStyle(
                       
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(
              color: Color(0xFFF1F5F9),
              thickness: 1.2,
              height: 1,
            ),
          ),

          // Total Estimate Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Estimate",
                style: TextStyle(
                       
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              Text(
                "₹${_formatNum(totalEstimate)}",
                style: const TextStyle(
                       
                  fontSize: 20,
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

  String _formatNum(int num) {
    return num.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
