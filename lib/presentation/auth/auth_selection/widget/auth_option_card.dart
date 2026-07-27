import 'package:flutter/material.dart';
import '../../../../controller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';


class AuthOptionCard extends StatelessWidget {
  final UserSelectionType userSelectionType;
  final bool? isSelected;
  final VoidCallback onTap;

  const AuthOptionCard({
    super.key,
    required this.userSelectionType,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 28),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorConstant.borderLightGreenColor.withValues(
                    alpha: 0.4,
                  ),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected == true
                        ? Colors.green.withValues(alpha: 0.8)
                        : Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                top: 38, // Extra top padding to clear the overlapping icon
                bottom: 20,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userSelectionType.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.appColor,

                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 1.5,
                    color: ColorConstant.borderLightGreenColor.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userSelectionType.subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.greyColor,

                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Overlapping Circle Icon
            Positioned(
              top: 0,
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.appColor,
                  border: Border.all(color: ColorConstant.whiteColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: isSelected == true
                      ? Icon(Icons.done, color: Colors.white)
                      : Image.asset(
                          userSelectionType.img,
                          color: ColorConstant.whiteColor,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
