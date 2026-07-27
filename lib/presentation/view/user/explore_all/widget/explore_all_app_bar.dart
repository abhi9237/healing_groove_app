import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ExploreAllAppBar extends StatelessWidget {
  const ExploreAllAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConstant.lightBlackColor,
                size: 22,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Explore Retreats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstant.lightBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
