import 'package:flutter/material.dart';
import '../../../../core/color_constant/color_constant.dart';


class PreferenceChip extends StatelessWidget {
  final String label;
  final bool? isSelected;
  final Function(String)? onSelected;

  const PreferenceChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onSelected!(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected == true
              ? ColorConstant.appColor
              : ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(22),
          border: isSelected == true
              ? Border.all(color: ColorConstant.appColor, width: 1.2)
              : Border.all(color: const Color(0xFFE2E6E4), width: 1.2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected == true
                ? ColorConstant.whiteColor
                : ColorConstant.greyColor,
            fontSize: 15,
            fontWeight: isSelected == true ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
