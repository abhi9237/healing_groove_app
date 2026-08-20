import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import '../../../../../common/common_bottom_sheet.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';

class CountryDropdown extends StatelessWidget {
  final SetupCenterDetailController controller;

  const CountryDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorConstant.greyColor.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 8),

        CommonTextFormFilled(
          controller: controller.countryController,
          hintText: 'Select country',
          suffixIcon: ImageConstant.downArrowIcon,
          readOnly: true,
          onTap: () {
            showCountrySelectionPicker(
              context,
              showPhoneCode: false,
              onSelect: (country) {
                controller.selectedCountry.value = country.name;
                controller.countryController.text = country.name;
              },
            );
          },
        ),
      ],
    );
  }
}
