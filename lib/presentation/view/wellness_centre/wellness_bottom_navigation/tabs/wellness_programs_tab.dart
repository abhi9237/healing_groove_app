import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class WellnessProgramsTab extends StatelessWidget {
  const WellnessProgramsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_rounded,
              size: 64,
              color: ColorConstant.appColor,
            ),
            SizedBox(height: 16),
            Text(
              'Wellness Programs',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Configure your packages and offers',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
