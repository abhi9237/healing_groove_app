import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';
import 'package:healing/controller/usercontroller/edit_profile_controller.dart';

import '../../../../../common/common_bottom_sheet.dart';
import '../../../../../common/common_widget.dart';

class EditPersonalSpaceCard extends StatelessWidget {
  final EditProfileController controller;

  const EditPersonalSpaceCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF3),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: ColorConstant.appColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Personal Space',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Your essential identification details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Full Name
          _buildTextField(
            label: 'Full Name',
            controller: controller.nameController,
          ),
          const SizedBox(height: 14),

          // Email Address (Read-only)
          _buildTextField(
            label: 'Email Address',
            controller: controller.emailController,
            readOnly: true,
          ),
          const SizedBox(height: 14),

          // Phone & Age Row
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Phone Number',
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Obx(
                    () => GestureDetector(
                      onTap: () {
                        showCountrySelectionPicker(
                          context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            controller.setCountryCode(true, country);
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 12, right: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.selectedPhoneCountryCode.value,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.lightBlackColor,
                              ),
                            ),

                            const SizedBox(width: 4),
                            Container(
                              width: 1,
                              height: 18,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  readOnly: true,
                  label: 'Age',
                  controller: controller.ageController,
                  onTap: () => controller.selectDob(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Gender & Country Dropdown Row
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Gender',
                  value: controller.selectedGender.value.capitalizeFirst ?? '',
                  onTap: () {
                    showGenderBottomSheet(
                      context: context,
                      title: 'Gender',
                      items: controller.genderList,
                      selectedValue: controller.selectedGender,
                      onSelected: (gender) {
                        controller.updateGender(gender);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Country',
                  value: controller.selectedCountry,
                  onTap: () {
                    showCountrySelectionPicker(
                      context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        controller.setCountryCode(false, country);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Save Changes Button (Green)
          Obx(
            () => controller.isLoadingSaveChanges.value == true
                ? CommonCircularIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.onTapUpdateProfile(context),
                      icon: const Icon(
                        Icons.save_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.appColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    final VoidCallback? onTap,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ColorConstant.greyColor,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          decoration: BoxDecoration(
            color: readOnly ? const Color(0xFFF5F7FA) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: readOnly ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType,
            onTap: onTap,
            style: const TextStyle(
              fontSize: 15,
              color: ColorConstant.lightBlackColor,
              fontWeight: FontWeight.w600,
            ),
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              prefixIcon: prefixIcon, // <-- Add this
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstant.appColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ColorConstant.greyColor,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          splashColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            width: 400,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.greyColor,
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
