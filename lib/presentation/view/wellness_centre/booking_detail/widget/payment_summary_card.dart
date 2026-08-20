import 'package:flutter/material.dart';
import '../../../../../common/common_methods.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../presentation/model/common/doc_model.dart';

class PaymentSummaryCard extends StatelessWidget {
  final DocModel booking;

  const PaymentSummaryCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final num total = booking.totalAmount ?? 0;
    final num paid = (booking.chargeAmount != null && booking.chargeAmount! > 0)
        ? booking.chargeAmount!
        : (booking.status?.toLowerCase() == 'confirmed' || booking.status?.toLowerCase() == 'completed')
            ? total
            : 0;
    final num balance = total - paid;
    final String status = paid >= total ? 'Payment Received' : 'Payment Pending';

    final String totalAmountStr = formatIndianPrice(total);
    final String paidAmountStr = formatIndianPrice(paid);
    final String balanceDueStr = formatIndianPrice(balance);
    final isPaid = balance == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PAYMENT SUMMARY",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Amount Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14.5,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    totalAmountStr,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Paid Amount Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Paid Amount",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14.5,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    paidAmountStr,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  color: Color(0xFFF1F5F9),
                  thickness: 1,
                  height: 1,
                ),
              ),

              // Balance Due Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BALANCE DUE",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                  Text(
                    balanceDueStr,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isPaid ? ColorConstant.appColor : const Color(0xFFC2410C),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Payment Status Banner/Pill
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: isPaid
                      ? const Color(0xFFE8F5E9) // Light green
                      : const Color(0xFFFEF2F2), // Light red/pink
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isPaid ? ColorConstant.appColor : Colors.red.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: isPaid ? ColorConstant.appColor : Colors.red.shade700,
                        letterSpacing: 0.4,
                      ),
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
}
