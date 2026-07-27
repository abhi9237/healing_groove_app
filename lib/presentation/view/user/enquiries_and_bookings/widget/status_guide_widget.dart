import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';
import 'package:healing/controller/enquiries_and_bookings_controller.dart';

class StatusGuideWidget extends StatelessWidget {
  final EnquiriesAndBookingsController controller;

  const StatusGuideWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC), // Light violet-blue tint
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAECF5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Info Icon, Title, and Close Button
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF175CD3), // Blue color matching guide
                size: 22,
              ),
              const SizedBox(width: 8),
              const Text(
                'Status Guide',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => controller.toggleStatusGuide(false),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Divider
          Divider(
            color: const Color(0xFFEAECF5),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 8),

          // Status rows
          _buildGuideRow(
            dotColor: const Color(0xFF175CD3), // Blue
            status: 'Pending',
            description: 'Enquiry received',
          ),
          _buildGuideRow(
            dotColor: const Color(0xFF027A48), // Green
            status: 'Converted',
            description: 'Booking completed',
          ),
          _buildGuideRow(
            dotColor: const Color(0xFF667085), // Grey
            status: 'Under review',
            description: 'Centre is reviewing',
          ),
        ],
      ),
    );
  }

  Widget _buildGuideRow({
    required Color dotColor,
    required String status,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
            ],
          ),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
