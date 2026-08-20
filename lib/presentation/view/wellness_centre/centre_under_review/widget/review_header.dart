import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ReviewHeader extends StatelessWidget {
  final String centerName;

  const ReviewHeader({
    super.key,
    required this.centerName,
  });

  @override
  Widget build(BuildContext context) {
    final String displayCenterName = centerName.trim().isEmpty ? '' : centerName.trim();

    return Column(
      children: [
        // Clock Icon with light peach/orange background circle
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFF7ED), // Light orange/yellow background
          ),
          child: const Center(
            child: Icon(
              Icons.access_time_filled_rounded,
              color: ColorConstant.orangeColor,
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Title
        const Text(
          'Application Under Review',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle with bold center name
        Text.rich(
          TextSpan(
            text: 'Thank you for submitting ',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: displayCenterName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.lightBlackColor,
                ),
              ),
              const TextSpan(text: ' for listing on The Healing Groove.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),

        // Paragraph 1
        Text(
          'Our team is currently reviewing your application. We will contact you shortly to discuss partnership details, agreements, and onboarding requirements.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14.5,
            height: 1.45,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 20),

        // Paragraph 2
        Text(
          'Once your center is approved, you will gain access to the Wellness Center Dashboard where you can create programs, services, packages, and manage bookings.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 14.5,
            height: 1.45,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
