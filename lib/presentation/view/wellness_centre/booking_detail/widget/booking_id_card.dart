import 'package:flutter/material.dart';
import '../../../../../common/common_methods.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../presentation/model/common/doc_model.dart';

class BookingIdCard extends StatelessWidget {
  final DocModel booking;

  const BookingIdCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final String bookingId = booking.bookingNumber ?? booking.id?.toString() ?? '';
    final String status = booking.status ?? 'Pending';
    final String totalAmount = formatIndianPrice(booking.totalAmount);
    final isPending = status.toLowerCase() == 'pending';

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
          // Row 1: Booking ID & Status Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BOOKING ID",
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bookingId,
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFFF7ED) // Orange background
                      : const Color(0xFFEFF6FF), // Blue background
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isPending
                        ? const Color(0xFFC2410C) // Orange text
                        : const Color(0xFF1D4ED8), // Blue text
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Row 2: Total Amount & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                totalAmount,
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 22,
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
}
