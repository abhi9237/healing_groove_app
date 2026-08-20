import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class WellnessBookingsTab extends StatelessWidget {
  const WellnessBookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 64,
              color: ColorConstant.appColor,
            ),
            SizedBox(height: 16),
            Text(
              'Manage Bookings',
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'View and schedule customer bookings',
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
