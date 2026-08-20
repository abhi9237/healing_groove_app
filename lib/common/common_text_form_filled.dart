import 'package:custom_image_view/custom_image_view.dart';
import 'package:flutter/material.dart';

import '../core/color_constant/color_constant.dart';

class CommonTextFormFilled extends StatelessWidget {
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onTapSuffixIcon;
  final VoidCallback? onTap;
  final int? maxLines;
  final double? height;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CommonTextFormFilled({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onTapSuffixIcon,
    this.maxLines = 1,
    this.height,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: height ?? 55),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: maxLines != null && maxLines! > 1 ? 16 : 16,
            bottom: maxLines != null && maxLines! > 1 ? 16 : 16,
            right: 15,
            left: prefixIcon == null ? 15 : 0,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w400,
          ),

          /// Prefix Icon
          prefixIcon: prefixIcon != null
              ? CustomImageView(
                  imagePath: prefixIcon,
                  fit: BoxFit.contain,
                  height: 15,
                  color: ColorConstant.lightBlackColor,
                )
              : null,

          prefixIconConstraints: const BoxConstraints(minWidth: 50),

          /// Suffix Icon
          suffixIcon: suffixIcon != null
              ? InkWell(
                  splashColor: Colors.transparent,
                  onTap: onTapSuffixIcon,
                  child: CustomImageView(
                    imagePath: suffixIcon,
                    fit: BoxFit.contain,
                    height: 15,
                    color: ColorConstant.lightBlackColor,
                  ),
                )
              : null,

          suffixIconConstraints: BoxConstraints(minWidth: height ?? 55),
        ),
      ),
    );
  }
}

class CommonDescriptionTextFormFilled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  const CommonDescriptionTextFormFilled({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText ?? false,
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

class CommonMapTextFormFilled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureIcon;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTapSuffixIcon;
  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTap;
  final Function(String)? onChangeText;
  final int? maxLength;
  final TextInputType? keyBoardType;
  final Color? fillColor;
  final bool readOnly;

  const CommonMapTextFormFilled({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureIcon,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.onTapPrefixIcon,
    this.onTap,
    this.prefixIcon,
    this.maxLength,
    this.keyBoardType,
    this.fillColor,
    this.onChangeText,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangeText,
      onTap: onTap,
      readOnly: readOnly,
      maxLength: maxLength,
      keyboardType: keyBoardType,
      style: TextStyle(color: ColorConstant.blackColor),
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      obscureText: isObscureIcon ?? false,
      controller: controller,
      decoration: InputDecoration(
        fillColor: fillColor ?? ColorConstant.whiteColor,
        filled: true,
        counterText: '',
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon: GestureDetector(
          onTap: onTapSuffixIcon,
          child: Icon(suffixIcon),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}

class CommonSearchTextFilled extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? suffixIcon;
  final String? hintText;
  final VoidCallback? onTapSuffixIcon;
  const CommonSearchTextFilled({
    super.key,
    required this.controller,
    this.onChanged,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 16,
          color: ColorConstant.lightBlackColor,
        ),
        decoration: InputDecoration(
          hintText:hintText?? 'Search by enquiry ID...',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey.shade400,
            size: 24,
          ),

          /// Suffix Icon
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: onTapSuffixIcon,
                    child: CustomImageView(
                      imagePath: suffixIcon,
                      fit: BoxFit.contain,
                      height: 15,
                      color: ColorConstant.lightBlackColor,
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
