import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class FixedAddServicesButton extends StatelessWidget {
  final VoidCallback onTap;

  const FixedAddServicesButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.appColor,
          elevation: 4,
          shadowColor: ColorConstant.appColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              "Add Services",
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
