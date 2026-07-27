import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class SavedProgramShimmer extends StatelessWidget {
  const SavedProgramShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image skeleton
            const AppShimmer(
              width: double.infinity,
              height: 200,
              radius: 0,
            ),
            
            // Details skeleton
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AppShimmer(width: 200, height: 20),
                      AppShimmer(width: 80, height: 24, radius: 8),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Location row
                  Row(
                    children: const [
                      AppShimmer(width: 16, height: 16, radius: 8),
                      SizedBox(width: 8),
                      AppShimmer(width: 120, height: 14),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Duration & Next Available Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AppShimmer(width: 80, height: 12),
                            SizedBox(height: 6),
                            AppShimmer(width: 100, height: 14),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AppShimmer(width: 80, height: 12),
                            SizedBox(height: 6),
                            AppShimmer(width: 100, height: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Button
                  const AppShimmer(
                    width: double.infinity,
                    height: 48,
                    radius: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
