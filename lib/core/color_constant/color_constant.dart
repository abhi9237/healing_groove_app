import 'package:flutter/material.dart';

class ColorConstant {
  static const Color darkColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color appColor = Color(0xFF08864F);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color redColor = Colors.red;
  static const Color lightGreenColor = Color(0xFFBCEECF);
  static const Color lightBlackColor = Color(0xFF022013);
  static const Color greyColor = Color(0xFF414943);
  static const Color borderLightGreenColor = Color(0xFF08864F);
  static const Color darkGreenColor = Color(0xFF00522F);
  static const Color orangeColor = Color(0xFFF97316);

}

class CommonGradientColor {
  static LinearGradient lightGradientColor = LinearGradient(
    colors: [
      ColorConstant.lightGreenColor.withValues(alpha: 0.2),
      ColorConstant.lightGreenColor.withValues(alpha: 0.2),
    ],
  );

  static LinearGradient welcomeGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ColorConstant.appColor.withValues(alpha: 0.7),
      ColorConstant.lightBlackColor,
    ],
  );

  static LinearGradient packageBackgroundGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      ColorConstant.appColor,
      ColorConstant.darkGreenColor,
    ],
  );
}
