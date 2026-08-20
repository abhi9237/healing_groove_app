import 'package:flutter/material.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/common/common_methods.dart';
import '../../../../../core/color_constant/color_constant.dart';

class BookingListItem extends StatelessWidget {
  final DocModel booking;
  final VoidCallback onViewTap;
  final VoidCallback onEditTap;

  const BookingListItem({
    super.key,
    required this.booking,
    required this.onViewTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final String name = booking.user?.name ??
        (booking.guests != null && booking.guests!.isNotEmpty
            ? booking.guests![0].fullName ?? 'Guest'
            : 'Guest');
    final String id = booking.bookingNumber ?? booking.id?.toString() ?? '';
    final int guests = booking.guests?.length ?? 1;
    final String status = booking.status ?? 'Pending';
    final String program = booking.package?.name ?? '';
    
    String datesText = '';
    if (booking.startDate != null) {
      try {
        final start = DateTime.parse(booking.startDate!).toLocal();
        final duration = booking.package?.duration ?? 1;
        final end = start.add(Duration(days: duration - 1));
        datesText = "${start.month}/${start.day}/${start.year} to\n${end.month}/${end.day}/${end.year}";
      } catch (_) {
        datesText = booking.startDate!;
      }
    }

    final String paymentStatus = booking.chargeAmount != null && booking.chargeAmount! > 0 ? 'Paid' : 'Pending';
    final String price = formatIndianPrice(booking.totalAmount);
    final String avatarUrl = booking.image?.url ?? '';

    final isRequested = status.toLowerCase() == 'requested';
    final isPaid = paymentStatus == 'Paid';

    return InkWell(
      onTap: onViewTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Row
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                    image: DecorationImage(
                      image: NetworkImage(
                        avatarUrl.startsWith('http')
                            ? avatarUrl
                            : 'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "$id • $guests ${guests > 1 ? 'Guests' : 'Guest'}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Status Badge

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'confirmed'
                        ?  ColorConstant.appColor
                        : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: status == 'confirmed'
                          ? ColorConstant.whiteColor
                          : const Color(0xFF1D4ED8),
                    ),
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
            ),

            // Program vs Dates Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Program Column
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Program",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        program,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Dates Column
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dates",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        datesText,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.lightBlackColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
            ),

            // Bottom Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Payment Status

                status == 'pending' ||
                    status == 'requested' ||
                    status == 'awaiting confirmation' ||
                    status ==  'initiated'||
                    status == 'awaiting_confirmation' ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Status",
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$paymentStatus • $price",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPaid
                            ? const Color(0xFF08864F)
                            : const Color(0xFFEA580C),
                      ),
                    ),
                  ],
                ):SizedBox(),

                // Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: onViewTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFEFF6FF,
                          ), // very light blue background
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.visibility_outlined,
                          color: Colors.grey.shade700,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onEditTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.grey.shade700,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
