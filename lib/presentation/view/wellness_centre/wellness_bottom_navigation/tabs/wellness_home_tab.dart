import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class WellnessHomeTab extends StatelessWidget {
  const WellnessHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_rounded,
              size: 64,
              color: ColorConstant.appColor,
            ),
            SizedBox(height: 16),
            Text(
              'Wellness Home Dashboard',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Overview of your wellness center activities',
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
