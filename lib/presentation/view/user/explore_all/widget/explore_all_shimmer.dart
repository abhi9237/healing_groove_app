import 'package:flutter/material.dart';
import 'package:healing/common/app_shimmer.dart';

class ExploreAllShimmer extends StatelessWidget {
  const ExploreAllShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppShimmer(
                width: double.infinity,
                height: 200,
                radius: 28,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppShimmer(width: 180, height: 24),
                    const SizedBox(height: 10),
                    const AppShimmer(width: 120, height: 16),
                    const SizedBox(height: 10),
                    const AppShimmer(width: 150, height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
