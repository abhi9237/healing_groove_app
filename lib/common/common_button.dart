import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';
import '../core/color_constant/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final String? nextImg;
  final String? frontImg;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? bgColor;
  final double? width;
  final double? borderRadius;
  final double? height;
  final FontWeight? fontWeight;
  final List<Color>? gradientColors;
  const CommonButton({
    super.key,
    required this.buttonText,
    this.onTap,
    this.frontImg,
    this.textColor,
    this.bgColor,
    this.borderRadius,
    this.gradientColors,
    this.width,
    this.height,
    this.nextImg,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 55,
        width: width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
          color: bgColor,
          gradient: LinearGradient(
            colors: bgColor == null
                ? gradientColors ??
                      [ColorConstant.appColor, ColorConstant.appColor]
                : [bgColor!, bgColor!],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (frontImg != null)
              CustomImageView(
                margin: EdgeInsets.only(left: 5),
                imagePath: frontImg,
                fit: BoxFit.contain,
                height: 15,
                width: 13,
              ),
            if (frontImg != null) SizedBox(width: 8),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? ColorConstant.whiteColor,
              ),
            ),

            if (nextImg != null)
              CustomImageView(
                margin: EdgeInsets.only(left: 5),
                imagePath: nextImg,
                fit: BoxFit.contain,
                height: 15,
                width: 13,
              ),
          ],
        ),
      ),
    );
  }
}

class CommonCircularButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String iconImg;
  const CommonCircularButton({super.key, required this.iconImg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstant.appColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Image.asset(iconImg, color: ColorConstant.whiteColor),
        ),
      ),
    );
  }
}

class CommonSocialLoginButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String iconImg;
  const CommonSocialLoginButton({super.key, required this.iconImg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorConstant.appColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(iconImg),
        ),
      ),
    );
  }
}
