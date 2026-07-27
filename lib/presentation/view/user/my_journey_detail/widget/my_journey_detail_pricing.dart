import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/my_journey_detail_controller.dart';

class MyJourneyDetailPricing extends StatelessWidget {
  final MyJourneyDetailController controller;

  const MyJourneyDetailPricing({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String paymentStatusText = (controller.status.toUpperCase() == 'CONFIRMED' || controller.status.toUpperCase() == 'COMPLETED')
        ? 'PAID'
        : (controller.status.toUpperCase() == 'CANCELLED' ? 'CANCELLED' : 'PENDING');
        
    final Color paymentStatusColor = (paymentStatusText == 'PAID')
        ? const Color(0xFF08864F)
        : (paymentStatusText == 'CANCELLED' ? Colors.grey : Colors.red);
        
    final Color paymentStatusBg = (paymentStatusText == 'PAID')
        ? const Color(0xFFE2F7EB)
        : (paymentStatusText == 'CANCELLED' ? const Color(0xFFF1F5F9) : const Color(0xFFFEF2F2));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Amount Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Booking Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.greyColor,
                  ),
                ),
                Text(
                  '₹${controller.amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Taxes & Fees Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Taxes & Fees',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.greyColor,
                  ),
                ),
                Text(
                  '₹${controller.taxes.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            
            // Divider
            Divider(color: Colors.grey.shade100, height: 1),
            const SizedBox(height: 14),
            
            // Total Payable Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left text & amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL PAYABLE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.greyColor.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${controller.totalPayable.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.appColor,
                      ),
                    ),
                  ],
                ),
                
                // Right status pending info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: paymentStatusBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        paymentStatusText,
                        style: TextStyle(
                          color: paymentStatusColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Amount Settled: ₹${controller.settledAmount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.greyColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Get Invoice PDF Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => controller.getInvoicePdf(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF6FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.file_download_outlined,
                      color: Color(0xFF1E40AF),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Get Invoice PDF',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E40AF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
