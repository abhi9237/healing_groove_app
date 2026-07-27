import 'package:flutter/material.dart';
import '../color_constant/color_constant.dart';

class AppTheme {
  static OutlineInputBorder _border({Color color = ColorConstant.appColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color, width: 2),
      );

  static final lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'Afacad',
      displayColor: ColorConstant.blackColor,
    ),
    scaffoldBackgroundColor: ColorConstant.whiteColor,
    appBarTheme: AppBarTheme(backgroundColor: ColorConstant.whiteColor),
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: EdgeInsets.all(20),
      // enabledBorder: _border(color: ColorConstant.lightGreyColor),
      focusedBorder: _border(color: ColorConstant.appColor),
      // errorBorder: _border(color: ColorConstant.lightWhiteColor),
      // focusedErrorBorder: _border(color: ColorConstant.pinkColor),
    ),
  );
}