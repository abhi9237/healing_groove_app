import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class CancelBookingShimmer extends StatelessWidget {
  const CancelBookingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Skeletons for three Info Rows
        ...List.generate(3, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppShimmer(width: 140, height: 16),
              AppShimmer(width: 100, height: 16),
            ],
          ),
        )),
        
        const SizedBox(height: 12),
        // Policy label & details shimmer
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              AppShimmer(width: 100, height: 14),
              SizedBox(height: 6),
              AppShimmer(width: 250, height: 14),
            ],
          ),
        ),

        const SizedBox(height: 24),
        // Refund Row Shimmer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            AppShimmer(width: 80, height: 20),
            AppShimmer(width: 100, height: 28, radius: 16),
          ],
        ),

        const SizedBox(height: 16),
        // Refund explanation box shimmer
        const AppShimmer(width: double.infinity, height: 60, radius: 16),

        const SizedBox(height: 24),
        // Reason field label
        const AppShimmer(width: 200, height: 18),
        const SizedBox(height: 10),
        // Reason field
        const AppShimmer(width: double.infinity, height: 100, radius: 16),

        const SizedBox(height: 20),
        // Checkbox row
        Row(
          children: const [
            AppShimmer(width: 24, height: 24, radius: 6),
            SizedBox(width: 12),
            Expanded(child: AppShimmer(width: double.infinity, height: 35)),
          ],
        ),

        const SizedBox(height: 30),
        // Buttons Shimmer
        const AppShimmer(width: double.infinity, height: 55, radius: 20),
        const SizedBox(height: 12),
        const AppShimmer(width: double.infinity, height: 55, radius: 20),
        const SizedBox(height: 30),
      ],
    );
  }
}
