import 'package:flutter/material.dart';
import '../../../../../core/color_constant/color_constant.dart';

class SupportButton extends StatelessWidget {
  final VoidCallback onTap;

  const SupportButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.appColor,
          elevation: 2,
          shadowColor: ColorConstant.appColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.mail_outline_rounded,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'Contact Support',
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
