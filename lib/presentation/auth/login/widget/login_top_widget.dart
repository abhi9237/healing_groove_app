import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/color_constant/color_constant.dart';
import '../../../../core/image_constant/image_constant.dart';

class LoginTopWidget extends StatelessWidget {
  const LoginTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.appLogo,
          height: 120,
          width: 120,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 40),
        Text(
          'Welcome Back',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ColorConstant.appColor,
            height: 1.0,
          ),
        ),   SizedBox(height:20),
        Text(
          'Continue your path to restorative \nwellness and inner balance.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorConstant.greyColor,
            height: 1.0,
          ),
        ),
        SizedBox(height:15),
      ],
    );
  }
}
