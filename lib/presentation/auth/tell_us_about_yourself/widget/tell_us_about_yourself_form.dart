import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:healing/common/common_text_form_filled.dart';
import '../../../../common/common_bottom_sheet.dart';
import '../../../../controller/create_account_controller.dart';
import '../../../../core/color_constant/color_constant.dart';

class TellUsAboutYourselfForm extends StatelessWidget {
  final CreateAccountController controller;
  const TellUsAboutYourselfForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: ColorConstant.borderLightGreenColor.withValues(alpha: 0.15),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date of Birth Label
            const Text(
              'Date of Birth',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 8),
            // Calendar Selection field
            _buildSelectionField(
              valueText: controller.selectedDob.value != null
                  ? controller.formattedDob
                  : '',
              hintText: 'DD / MM / YYYY',
              suffixIcon: Icons.calendar_today_outlined,
              onTap: () => controller.selectDob(context, controller),
            ),
            const SizedBox(height: 18),

            // Gender Label
            const Text(
              'Gender',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 8),
            // Gender Dropdown field
            _buildSelectionField(
              valueText: controller.selectedGender.value,
              hintText: 'Select gender',
              suffixIcon: Icons.arrow_drop_down_rounded,
              iconSize: 28,
              onTap: () =>
                  controller.showGenderBottomSheet(context, controller),
            ),
            const SizedBox(height: 18),

            // Country Label
            const Text(
              'Country',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 8),
            // Country Dropdown field
            _buildSelectionField(
              valueText: controller.selectedCountry.value,
              hintText: 'Select country',
              suffixIcon: Icons.arrow_drop_down_rounded,
              iconSize: 28,
              onTap: () => showCountrySelectionPicker(
                context,
                showPhoneCode: false,
                onSelect: (Country country) {
                  controller.setCountryCode(false, country);
                },
              ),
            ),
            const SizedBox(height: 18),

            // Phone Number (Optional) Label
            const Text(
              'Phone Number (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightBlackColor,
              ),
            ),
            const SizedBox(height: 8),
            // Phone Number Row inputs
            Row(
              children: [
                // Country Code selector
                GestureDetector(
                  onTap: () =>
                      showCountrySelectionPicker(
                    context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      controller.setCountryCode(true, country);
                    },
                  ),
                  child: Container(
                    height: 68,
                    width: 95,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            controller.selectedPhoneCountryCode.value,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.grey.shade500,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Mobile Number text field
                Expanded(
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    child: CommonTextFormFilled(
                      hintText: 'Mobile Number',
                      controller: controller.phoneController.value,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSelectionField({
    required String valueText,
    required String hintText,
    required IconData suffixIcon,
    required VoidCallback onTap,
    double iconSize = 22,
  }) {
    final bool hasValue = valueText.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hasValue ? valueText : hintText,
              style: TextStyle(
                fontSize: 16,
                color: hasValue
                    ? ColorConstant.lightBlackColor
                    : Colors.grey.shade400,
                fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                fontFamily: 'Afacad',
              ),
            ),
            Icon(
              suffixIcon,
              color: hasValue ? ColorConstant.appColor : Colors.grey.shade400,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
