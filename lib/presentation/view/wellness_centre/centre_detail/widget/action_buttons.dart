import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/color_constant/color_constant.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onContinue;

  const ActionButtons({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        Expanded(
          child: SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                context.pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorConstant.appColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.appColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Continue Button
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.appColor,
                elevation: 2,
                shadowColor: ColorConstant.appColor.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
