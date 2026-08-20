import 'package:flutter/material.dart';
import 'package:healing/common/common_text_form_filled.dart';
import 'package:healing/controller/wellnesscentrecontroller/wellness_settings_controller.dart';
import '../../../../../core/color_constant/color_constant.dart';

class SettingsFormSections extends StatelessWidget {
  final WellnessSettingsController controller;

  const SettingsFormSections({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Public Listing Details
        _buildSectionHeader(Icons.star_outline_rounded, 'Public Listing Details'),
        const SizedBox(height: 12),
        _buildLabel('Rating (0-5)'),
        _buildTextField(controller.ratingController, 'e.g. 4.8', keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildLabel('Starting Price (₹)'),
        _buildTextField(controller.startingPriceController, 'e.g. 15000', keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildLabel('Program Duration'),
        _buildTextField(controller.durationController, 'e.g. 7-14 days'),
        const SizedBox(height: 16),
        _buildLabel('Availability'),
        _buildTextField(controller.availabilityController, 'e.g. Available this month'),
        const SizedBox(height: 28),

        // 2. Core Identity
        _buildSectionHeader(Icons.description_outlined, 'Core Identity'),
        const SizedBox(height: 12),
        _buildLabel('Center Name'),
        _buildTextField(controller.nameController, 'e.g. Healing Groove Wellness Center'),
        const SizedBox(height: 16),
        _buildLabel('Center Description'),
        _buildTextField(controller.descriptionController, 'Describe your center and specialties', maxLines: 4),
        const SizedBox(height: 16),
        _buildLabel('Speciality / Focus'),
        _buildTextField(controller.specialityController, 'e.g. Panchakarma & Detox'),
        const SizedBox(height: 16),
        _buildLabel('Total Staff'),
        _buildTextField(controller.staffController, 'e.g. 15 Specialized Practitioners', keyboardType: TextInputType.number),
        const SizedBox(height: 28),

        // 3. Contact Information
        _buildSectionHeader(Icons.phone_outlined, 'Contact Information'),
        const SizedBox(height: 12),
        _buildLabel('Phone'),
        _buildTextField(controller.phoneController, 'e.g. 9876543210', keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        _buildLabel('Email'),
        _buildTextField(controller.emailController, 'e.g. mohalicenter@healing.com', keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 28),

        // 4. Location
        _buildSectionHeader(Icons.location_on_outlined, 'Location'),
        const SizedBox(height: 12),
        _buildLabel('Address'),
        _buildTextField(controller.addressController, 'e.g. Phase 8B, Industrial Area'),
        const SizedBox(height: 16),
        _buildLabel('City'),
        _buildTextField(controller.cityController, 'e.g. Mohali'),
        const SizedBox(height: 16),
        _buildLabel('State'),
        _buildTextField(controller.stateController, 'e.g. Punjab'),
        const SizedBox(height: 16),
        _buildLabel('Country'),
        _buildTextField(controller.countryController, 'e.g. India'),
        const SizedBox(height: 16),
        _buildLabel('Postal Code'),
        _buildTextField(controller.postalCodeController, 'e.g. 160055', keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorConstant.appColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstant.lightBlackColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Afacad',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController textController,
    String hint, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return CommonTextFormFilled(
      height: 48,
      hintText: hint,
      controller: textController,
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }
}
