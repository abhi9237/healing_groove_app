import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class MyJourneyShimmer extends StatelessWidget {
  const MyJourneyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Shimmer
                const AppShimmer(
                  width: double.infinity,
                  height: 200,
                  radius: 24, // Matches the top border radius of the card
                ),

                // Details Shimmer
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking ID/Title
                      const AppShimmer(width: 140, height: 20),
                      const SizedBox(height: 14),

                      // Location
                      Row(
                        children: const [
                          Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
                          SizedBox(width: 8),
                          AppShimmer(width: 180, height: 14),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Meta Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AppShimmer(width: 70, height: 14),
                          AppShimmer(width: 70, height: 14),
                          AppShimmer(width: 70, height: 14),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: const [
                          Expanded(
                            child: AppShimmer(
                              width: double.infinity,
                              height: 48,
                              radius: 12,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: AppShimmer(
                              width: double.infinity,
                              height: 48,
                              radius: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
