import 'package:flutter/material.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../core/color_constant/color_constant.dart';

class MyJourneyAppBar extends StatelessWidget {
  const MyJourneyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonAppBar(title: 'My Journeys', showBackButton: false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Track your wellness journeys, past and present.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorConstant.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
