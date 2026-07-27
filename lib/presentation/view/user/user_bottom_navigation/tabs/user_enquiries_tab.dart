import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';


class UserEnquiriesTab extends StatelessWidget {
  const UserEnquiriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Enquiries',
          style: TextStyle(
            fontSize: 22,
            color: ColorConstant.lightBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: ColorConstant.lightBlackColor),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildBookingCard(
            title: 'Chakra Awakening Sound Therapy',
            type: 'Wellness Session',
            date: 'June 25, 2026 at 3:00 PM',
            location: 'Soul Harmony Sanctuary, Bandra',
            status: 'Approved',
            color: const Color(0xFFE2F7EB),
            statusColor: ColorConstant.appColor,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            title: 'Panchakarma Detox consultation',
            type: 'Doctor Consultation',
            date: 'June 28, 2026 at 11:30 AM',
            location: 'Healing Groove Wellness, Juhu',
            status: 'Pending Review',
            color: const Color(0xFFFFF3E0),
            statusColor: Colors.orange.shade700,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            title: '3-Day Ayurvedic Healing Retreat',
            type: 'Retreat Booking',
            date: 'July 15 - July 18, 2026',
            location: 'Mountain Serenity Centre, Lonavala',
            status: 'Approved',
            color: const Color(0xFFE2F7EB),
            statusColor: ColorConstant.appColor,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            title: 'Individual Vinyasa Yoga Session',
            type: 'Private Class',
            date: 'June 18, 2026 at 8:00 AM',
            location: 'Virtual Call (Zoom)',
            status: 'Completed',
            color: const Color(0xFFE3F2FD),
            statusColor: Colors.blue.shade700,
          ),
          const SizedBox(height: 100), // Spacing for floating bottom bar
        ],
      ),
    );
  }

  Widget _buildBookingCard({
    required String title,
    required String type,
    required String date,
    required String location,
    required String status,
    required Color color,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  color: ColorConstant.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 13,
                    color: ColorConstant.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Cancel Request',
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.appColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
