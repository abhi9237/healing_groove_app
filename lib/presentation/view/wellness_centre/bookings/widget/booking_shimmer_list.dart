import 'package:flutter/material.dart';
import '../../../../../common/app_shimmer.dart';

class BookingShimmerList extends StatelessWidget {
  const BookingShimmerList({super.key});

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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AppShimmer(width: 48, height: 48, radius: 24),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmer(width: 120, height: 16, radius: 4),
                        SizedBox(height: 6),
                        AppShimmer(width: 80, height: 12, radius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const AppShimmer(width: 70, height: 22, radius: 12),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmer(width: 60, height: 12, radius: 4),
                        SizedBox(height: 6),
                        AppShimmer(width: 140, height: 16, radius: 4),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmer(width: 60, height: 12, radius: 4),
                        SizedBox(height: 6),
                        AppShimmer(width: 120, height: 16, radius: 4),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Color(0xFFF1F5F9), thickness: 1, height: 1),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer(width: 80, height: 12, radius: 4),
                      SizedBox(height: 6),
                      AppShimmer(width: 110, height: 16, radius: 4),
                    ],
                  ),
                  Row(
                    children: [
                      AppShimmer(width: 40, height: 40, radius: 8),
                      SizedBox(width: 8),
                      AppShimmer(width: 40, height: 40, radius: 8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
