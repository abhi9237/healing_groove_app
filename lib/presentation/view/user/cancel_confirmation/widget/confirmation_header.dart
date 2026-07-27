import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ConfirmationHeader extends StatelessWidget {
  const ConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Green circle checkmark
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: ColorConstant.appColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.appColor.withValues(alpha: 0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: ColorConstant.appColor,
                size: 36,
              ),
            ),
          ),
        ),
        const SizedBox(height: 35),
        
        // Cancellation Requested Text
        const Text(
          'Cancellation Requested',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: ColorConstant.lightBlackColor,
            fontFamily: 'Afacad',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        
        // Description
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Your cancellation request has been submitted to the admin for review. You will receive an email once it is processed.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorConstant.greyColor,
              fontFamily: 'Afacad',
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
