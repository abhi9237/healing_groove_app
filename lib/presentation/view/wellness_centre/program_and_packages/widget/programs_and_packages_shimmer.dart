import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class ProgramsAndPackagesShimmer extends StatelessWidget {
  const ProgramsAndPackagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
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
              // Header Row Shimmer
              Row(
                children: [
                  const AppShimmer(width: 44, height: 44, radius: 10),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppShimmer(width: 160, height: 16),
                        const SizedBox(height: 6),
                        const AppShimmer(width: 90, height: 16, radius: 6),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Description Shimmer
              const AppShimmer(width: double.infinity, height: 14),
              const SizedBox(height: 6),
              const AppShimmer(width: 250, height: 14),
              const SizedBox(height: 20),

              // Details Grid Shimmer (2 columns, 2 rows)
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const AppShimmer(width: 24, height: 24, radius: 12),
                        const SizedBox(width: 8),
                        const AppShimmer(width: 70, height: 13),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const AppShimmer(width: 24, height: 24, radius: 12),
                        const SizedBox(width: 8),
                        const AppShimmer(width: 70, height: 13),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const AppShimmer(width: 24, height: 24, radius: 12),
                        const SizedBox(width: 8),
                        const AppShimmer(width: 70, height: 13),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const AppShimmer(width: 24, height: 24, radius: 12),
                        const SizedBox(width: 8),
                        const AppShimmer(width: 70, height: 13),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Divider(
                color: Color(0xFFF1F5F9),
                thickness: 1.2,
                height: 1,
              ),
              const SizedBox(height: 16),

              // Bottom Action Buttons Shimmer
              Row(
                children: [
                  Expanded(
                    child: const AppShimmer(width: double.infinity, height: 44, radius: 8),
                  ),
                  const SizedBox(width: 8),
                  const AppShimmer(width: 44, height: 44, radius: 8),
                  const SizedBox(width: 8),
                  const AppShimmer(width: 44, height: 44, radius: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
