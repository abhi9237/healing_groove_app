import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: width,
      height: height,
      radius: radius,
      fadeTheme: FadeTheme.light,
    );
  }
}