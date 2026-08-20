import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_bottom_sheet.dart';
import '../../../../../core/color_constant/color_constant.dart';
import '../../../../../controller/wellnesscentrecontroller/setup_center_detail_controller.dart';

class PhoneNumberInput extends StatelessWidget {
  final SetupCenterDetailController controller;

  const PhoneNumberInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number (Optional)',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorConstant.greyColor.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Code Box
            GestureDetector(
              onTap: () {
                showCountrySelectionPicker(
                  context,
                  showPhoneCode: true,
                  onSelect: (country) {
                    controller.phoneCountryCode.value = '+${country.phoneCode}';
                  },
                );
              },
              child: Obx(() => Container(
                height: 56,
                width: 85,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFBFB),
                  border: Border.all(color: Colors.grey.shade200, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.phoneCountryCode.value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                      size: 18,
                    ),
                  ],
                ),
              )),
            ),
            const SizedBox(width: 12),
            // Phone Number Input
            Expanded(
              child: TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    final cleanValue = value.trim();
                    if (cleanValue.length < 8 || cleanValue.length > 15) {
                      return 'Enter a valid phone number';
                    }
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorConstant.lightBlackColor,
                ),
                decoration: InputDecoration(
                  hintText: '1234 567 890',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFAFBFB),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
