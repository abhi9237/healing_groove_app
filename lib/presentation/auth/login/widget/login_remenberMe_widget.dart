import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onForgotPassword;

  const RememberMeWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Remember Me
        Row(
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: Checkbox(
                activeColor: ColorConstant.appColor,
                focusColor: ColorConstant.appColor,
                value: value,
                onChanged: onChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),

            const SizedBox(width: 3),

            Text(
              'Remember me',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),

        /// Forgot Password
        GestureDetector(
          onTap: onForgotPassword,
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF006B4F),
            ),
          ),
        ),
      ],
    );
  }
}
