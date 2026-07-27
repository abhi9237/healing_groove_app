import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class EnquiriesAndBookingsShimmer extends StatelessWidget {
  const EnquiriesAndBookingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade100, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: ID Tag and Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    AppShimmer(width: 80, height: 24, radius: 8),
                    AppShimmer(width: 100, height: 24, radius: 16),
                  ],
                ),
                const SizedBox(height: 16),

                // Title and Chevron Right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: AppShimmer(width: double.infinity, height: 22, radius: 4)),
                    SizedBox(width: 16),
                    AppShimmer(width: 24, height: 24, radius: 12),
                  ],
                ),
                const SizedBox(height: 14),

                // Location Row
                Row(
                  children: const [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    AppShimmer(width: 180, height: 16, radius: 4),
                  ],
                ),
                const SizedBox(height: 10),

                // Divider
                Divider(
                  color: Colors.grey.shade100,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 10),

                // Footer Row: Date and Updated At
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        AppShimmer(width: 80, height: 14, radius: 4),
                      ],
                    ),
                    AppShimmer(width: 100, height: 14, radius: 4),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
