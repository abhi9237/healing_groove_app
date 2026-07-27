import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _headerCard(),
            const SizedBox(height: 24),
            _personalSpaceCard(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: ColorConstant.greyColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          FadeShimmer.round(size: 100, fadeTheme: FadeTheme.light),

          const SizedBox(height: 24),

          FadeShimmer(
            height: 22,
            width: 170,
            radius: 8,
            fadeTheme: FadeTheme.light,
          ),

          const SizedBox(height: 14),

          FadeShimmer(
            height: 16,
            width: 220,
            radius: 8,
            fadeTheme: FadeTheme.light,
          ),

          const SizedBox(height: 24),

          FadeShimmer(
            height: 36,
            width: 90,
            radius: 20,
            fadeTheme: FadeTheme.light,
          ),
        ],
      ),
    );
  }

  Widget _personalSpaceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FadeShimmer.round(size: 42, fadeTheme: FadeTheme.light),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeShimmer(
                    height: 18,
                    width: 170,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                  ),
                  const SizedBox(height: 8),
                  FadeShimmer(
                    height: 14,
                    width: 220,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 28),

          _field(),
          const SizedBox(height: 18),

          _field(),
          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(child: _field()),
              const SizedBox(width: 16),
              Expanded(child: _field()),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(child: _field()),
              const SizedBox(width: 16),
              Expanded(child: _field()),
            ],
          ),

          const SizedBox(height: 28),

          FadeShimmer(
            height: 55,
            width: double.infinity,
            radius: 14,
            fadeTheme: FadeTheme.light,
          ),
        ],
      ),
    );
  }

  Widget _field() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeShimmer(
          height: 14,
          width: 80,
          radius: 6,
          fadeTheme: FadeTheme.light,
        ),

        const SizedBox(height: 10),

        FadeShimmer(
          height: 56,
          width: double.infinity,
          radius: 12,
          fadeTheme: FadeTheme.light,
        ),
      ],
    );
  }
}
