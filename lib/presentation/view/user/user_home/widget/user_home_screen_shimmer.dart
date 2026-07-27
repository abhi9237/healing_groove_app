import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class UserHomeShimmer extends StatelessWidget {
  const UserHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AppShimmer(width: 220, height: 28),
                      SizedBox(height: 16),
                      AppShimmer(width: 180, height: 18),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const AppShimmer(width: 52, height: 52, radius: 26),
              ],
            ),

            const SizedBox(height: 30),

            /// Stats Cards
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (_, _) {
                  return Container(
                    width: width * .42,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmer(width: 80, height: 16),
                        Spacer(),
                        AppShimmer(width: 50, height: 34),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            /// Title
            Row(
              children: [
                Container(width: 4, height: 50, color: Colors.grey.shade300),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer(width: 240, height: 24),
                      SizedBox(height: 8),
                      AppShimmer(width: 260, height: 15),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Align(
              alignment: Alignment.centerRight,
              child: const AppShimmer(width: 90, height: 16),
            ),

            const SizedBox(height: 24),

            /// Cards
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (_, __) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppShimmer(
                        width: double.infinity,
                        height: 240,
                        radius: 28,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppShimmer(width: 180, height: 24),

                            const SizedBox(height: 14),

                            const AppShimmer(width: 150, height: 16),

                            const SizedBox(height: 25),

                            Align(
                              alignment: Alignment.centerRight,
                              child: const AppShimmer(
                                width: 180,
                                height: 50,
                                radius: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
